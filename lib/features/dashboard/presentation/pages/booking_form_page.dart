import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/arena.dart';
import '../../domain/entities/booking.dart';
import '../cubit/booking_form/booking_form_cubit.dart';
import '../cubit/profile/profile_cubit.dart';

@RoutePage()
class BookingFormPage extends StatefulWidget {
  final Arena arena;

  const BookingFormPage({super.key, required this.arena});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  String? selectedField;
  DateTime? selectedDate;
  List<String> selectedTimeSlots = [];
  List<Map<String, dynamic>> availableTimeSlots = [];
  String? userId;

  // Dummy bookings for testing
  // Dummy bookings for testing
  final List<Booking> dummyBookings = [
    Booking(
      id: "1",
      arenaId: "arena_1",
      userId: "user_1",
      fieldId: "Field 1",
      date: DateTime(2025, 1, 18), // 18-01-2025
      timeSlots: [
        {"start": "07:00", "end": "08:00"},
        {"start": "09:00", "end": "10:00"},
      ],
      totalPrice: 20.0,
      status: "confirmed",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Booking(
      id: "2",
      arenaId: "arena_1",
      userId: "user_2",
      fieldId: "Field 2",
      date: DateTime(2025, 1, 18),
      timeSlots: [
        {"start": "15:00", "end": "16:00"},
      ],
      totalPrice: 10.0,
      status: "pending",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch user profile if not already loaded
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book ${widget.arena.name}"),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccess) {
            userId = state.user.id; // Extract userId from the loaded profile
          } else if (state is ProfileError) {
            return Center(
                child: Text("Failed to load profile: ${state.message}"));
          }
          return SingleChildScrollView(
            child: Padding(
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
                        value: field["name"],
                        child:
                            Text("${field["name"]} (\$${field["price"]}/hour)"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedField = value;
                        selectedTimeSlots
                            .clear(); // Clear previously selected slots
                        _generateTimeSlots();
                      });
                    },
                    value: selectedField,
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
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                          selectedTimeSlots
                              .clear(); // Clear previously selected slots
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

                  // Time Slot Selection
                  if (availableTimeSlots.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Time Slots",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: availableTimeSlots.map((slotData) {
                            final slot = slotData["slot"] as String;
                            final isEnabled = slotData["enabled"] as bool;

                            return FilterChip(
                              label: Text(
                                slot,
                                style: TextStyle(
                                  color: selectedTimeSlots.contains(slot)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              selected: selectedTimeSlots.contains(slot),
                              onSelected: isEnabled
                                  ? (isSelected) {
                                      setState(() {
                                        if (isSelected) {
                                          selectedTimeSlots.add(slot);
                                        } else {
                                          selectedTimeSlots.remove(slot);
                                        }
                                      });
                                    }
                                  : null,
                              selectedColor: Colors.teal,
                              backgroundColor: isEnabled
                                  ? Colors.grey.shade200
                                  : Colors.grey.shade400,
                              side: BorderSide(
                                color: selectedTimeSlots.contains(slot)
                                    ? Colors.teal
                                    : Colors.transparent,
                              ),
                              showCheckmark:
                                  false, // Hides the default checkmark icon
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Price Display
                  if (selectedTimeSlots.isNotEmpty)
                    Text(
                      "Total Price: \$${_calculatePrice().toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 32),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: selectedField != null &&
                            selectedDate != null &&
                            selectedTimeSlots.isNotEmpty
                        ? () {
                            _confirmBooking(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Confirm Booking",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Generate time slots
  void _generateTimeSlots() {
    if (selectedField == null || selectedDate == null) {
      setState(() {
        availableTimeSlots = [];
      });
      return;
    }

    final fieldData = widget.arena.availableFields.firstWhere(
      (field) => field['name'] == selectedField,
    );

    final openingHour = _parseTime(fieldData['openingHour']);
    final closingHour = _parseTime(fieldData['closingHour']);

    if (openingHour == null || closingHour == null) {
      setState(() {
        availableTimeSlots = [];
      });
      return;
    }

    final openingDateTime = _toDateTime(selectedDate!, openingHour);
    final closingDateTime = _toDateTime(selectedDate!, closingHour);

    final now = DateTime.now();
    final List<Map<String, dynamic>> timeSlots = [];
    DateTime currentTime = openingDateTime;

    while (currentTime.isBefore(closingDateTime)) {
      final isPast = currentTime.isBefore(now) ||
          currentTime.isBefore(now.add(const Duration(hours: 1)));

      final slotStart = _formatTime(currentTime);
      final slotEnd = _formatTime(currentTime.add(const Duration(hours: 1)));

      // Check if the time slot is already booked
      final isBooked = dummyBookings.any((booking) =>
          booking.fieldId == selectedField &&
          booking.date == selectedDate &&
          booking.timeSlots.any(
              (slot) => slot["start"] == slotStart && slot["end"] == slotEnd));

      timeSlots.add({
        "slot": "$slotStart - $slotEnd",
        "enabled": !isPast && !isBooked,
      });
      currentTime = currentTime.add(const Duration(hours: 1));
    }

    setState(() {
      availableTimeSlots = timeSlots;
    });
  }

  // Parse time string (HH:mm) to TimeOfDay
  TimeOfDay? _parseTime(String time) {
    try {
      final parts = time.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    } catch (_) {
      return null;
    }
  }

  // Convert TimeOfDay to DateTime
  DateTime _toDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  // Format DateTime to HH:mm
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  // Calculate total price
  double _calculatePrice() {
    final fieldData = widget.arena.availableFields.firstWhere(
      (field) => field["name"] == selectedField,
    );
    final pricePerHour = fieldData["price"] as double;
    return selectedTimeSlots.length * pricePerHour;
  }

  // Confirm booking
  void _confirmBooking(BuildContext context) {
    final bookingCubit = context.read<BookingFormCubit>();

    final bookingDetails = selectedTimeSlots.map((slot) {
      final timeSlotParts = slot.split(" - ");
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

      return {
        "startTime": startTime,
        "endTime": endTime,
      };
    }).toList();

    bookingCubit.createBooking(
      arenaId: widget.arena.id,
      fieldId: selectedField!,
      userId: userId!, // Replace with actual user ID
      bookings: bookingDetails,
      totalPrice: _calculatePrice(),
    );

    Navigator.pop(context);
  }
}
