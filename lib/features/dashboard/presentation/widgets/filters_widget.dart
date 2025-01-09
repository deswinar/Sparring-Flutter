import 'package:flutter/material.dart';

class FiltersWidget extends StatelessWidget {
  final VoidCallback onApplyFilters;

  const FiltersWidget({super.key, required this.onApplyFilters});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onApplyFilters,
      child: const Text("Apply Filters"),
    );
  }
}
