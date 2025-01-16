import 'package:flutter/material.dart';

class BookingFieldDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> availableFields;

  const BookingFieldDropdown({super.key, required this.availableFields});

  @override
  _BookingFieldDropdownState createState() => _BookingFieldDropdownState();
}

class _BookingFieldDropdownState extends State<BookingFieldDropdown> {
  String? selectedField; // Holds the currently selected field

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedField,
      items: widget.availableFields.map((field) {
        return DropdownMenuItem<String>(
          value: field["name"],
          child: Text(field["name"]),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedField = value;
        });
      },
      decoration: const InputDecoration(
        labelText: 'Select Field',
        border: OutlineInputBorder(),
      ),
    );
  }
}
