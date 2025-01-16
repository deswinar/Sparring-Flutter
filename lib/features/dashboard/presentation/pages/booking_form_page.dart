import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../domain/entities/arena.dart';
import '../cubit/booking_form/booking_form_cubit.dart';

@RoutePage()
class BookingFormPage extends StatefulWidget {
  final Arena arena;

  const BookingFormPage({super.key, required this.arena});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  String? selectedField;
  String? selectedTimeSlot;
  DateTime? selectedDate;
  double? calculatedPrice;
  List<String> availableTimeSlots = [];

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) print("Available Fields: ${widget.arena.availableFields}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Book ${widget.arena.name}"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select Field",
                border: OutlineInputBorder(),
              ),
              items: widget.arena.availableFields.map((field) {
                return DropdownMenuItem<String>(
                  value: field["name"], // Ensure this matches selectedField
                  child: Text("${field["name"]} (\$${field["price"]}/hour)"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  if (kDebugMode) print("Selected Field: $selectedField");
                  if (kDebugMode) print("Selected Date: $selectedDate");
                  selectedField = value;
                  selectedTimeSlot = null; // Reset selected time slot
                  calculatedPrice = null; // Reset price
                  _generateTimeSlots();
                });
              },
              value: widget.arena.availableFields
                      .any((field) => field["name"] == selectedField)
                  ? selectedField
                  : null, // Ensure the value exists in items
            ),

            const SizedBox(height: 16),

            // Date Picker
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Select Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (kDebugMode) print("Selected Field: $selectedField");
                if (kDebugMode) print("Selected Date: $selectedDate");
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                    selectedTimeSlot = null; // Reset selected time slot
                    _generateTimeSlots();
                  });
                }
              },
              controller: TextEditingController(
                text: selectedDate != null
                    ? DateFormat("yyyy-MM-dd").format(selectedDate!)
                    : "",
              ),
            ),
            const SizedBox(height: 16),

            // Time Slot Dropdown
            // Time Slot Selection
            if (availableTimeSlots.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Time Slot",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: availableTimeSlots.map((slot) {
                      bool isOccupied = _isTimeSlotOccupied(slot);
                      return GestureDetector(
                        onTap: isOccupied
                            ? null
                            : () {
                                setState(() {
                                  selectedTimeSlot = slot;
                                  calculatedPrice = _calculatePrice();
                                });
                              },
                        child: Chip(
                          label: Text(
                            slot,
                            style: TextStyle(
                              color: isOccupied ? Colors.white : Colors.black,
                            ),
                          ),
                          backgroundColor:
                              isOccupied ? Colors.red : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            // Price Display
            if (calculatedPrice != null)
              Text(
                "Total Price: \$${calculatedPrice!.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 32),

            // Confirm Button
            ElevatedButton(
              onPressed: selectedField != null &&
                      selectedDate != null &&
                      selectedTimeSlot != null
                  ? () {
                      _confirmBooking(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
              ),
              child: const Center(
                child: Text(
                  "Confirm Booking",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to check if a time slot is occupied
  bool _isTimeSlotOccupied(String slot) {
    // Replace this logic with actual occupied time slots data
    // Currently, assuming no slots are occupied for demo purposes
    // Example: Use a list of occupied time slots and check if the slot is in the list
    return false;
  }

  void _generateTimeSlots() {
    if (selectedField == null || selectedDate == null) {
      setState(() {
        availableTimeSlots = []; // No time slots available
      });
      return;
    }

    // Find the selected field
    final fieldData = widget.arena.availableFields.firstWhere(
      (field) => field['name'] == selectedField,
      orElse: () => {}, // Return an empty map if no match is found
    );

    if (fieldData.isEmpty) {
      setState(() {
        availableTimeSlots = []; // Reset time slots if field not found
      });
      return;
    }

    // Extract opening and closing hours
    final openingHour = _parseTime(fieldData['openingHour']);
    final closingHour = _parseTime(fieldData['closingHour']);

    if (openingHour == null || closingHour == null) {
      setState(() {
        availableTimeSlots = []; // Invalid hours, no time slots
      });
      return;
    }

    // Convert TimeOfDay to DateTime for comparison
    final openingDateTime = _toDateTime(selectedDate!, openingHour);
    final closingDateTime = _toDateTime(selectedDate!, closingHour);

    if (openingDateTime.isAfter(closingDateTime)) {
      setState(() {
        availableTimeSlots = []; // Invalid range, no time slots
      });
      return;
    }

    // Generate time slots (e.g., 1-hour intervals)
    final List<String> timeSlots = [];
    DateTime currentTime = openingDateTime;

    while (currentTime.isBefore(closingDateTime)) {
      timeSlots.add(
          "${_formatTime(currentTime)} - ${_formatTime(currentTime.add(const Duration(hours: 1)))}");
      currentTime = currentTime.add(const Duration(hours: 1));
    }

    setState(() {
      availableTimeSlots = timeSlots;
    });
  }

// Helper function to parse time (HH:mm format)
  TimeOfDay? _parseTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length != 2) return null;
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }

// Helper function to format DateTime into HH:mm
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

// Helper function to convert TimeOfDay to DateTime
  DateTime _toDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  double _calculatePrice() {
    final selectedFieldData = widget.arena.availableFields.firstWhere(
      (field) => field["id"] == selectedField,
    );
    return selectedFieldData["price"] as double;
  }

  void _confirmBooking(BuildContext context) {
    final bookingCubit = context.read<BookingFormCubit>();

    final timeSlotParts = selectedTimeSlot!.split(" - ");
    final startTimeParts = timeSlotParts[0].split(":");
    final endTimeParts = timeSlotParts[1].split(":");

    final startTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      int.parse(startTimeParts[0]),
      int.parse(startTimeParts[1]),
    );

    final endTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      int.parse(endTimeParts[0]),
      int.parse(endTimeParts[1]),
    );

    bookingCubit.createBooking(
      arenaId: widget.arena.id,
      fieldId: selectedField!,
      userId: "dummy_user_id", // Replace with actual user ID
      startTime: startTime,
      endTime: endTime,
      totalPrice: calculatedPrice!,
    );
    Navigator.pop(context);
  }
}
