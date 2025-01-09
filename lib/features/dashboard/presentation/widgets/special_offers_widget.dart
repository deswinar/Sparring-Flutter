import 'package:flutter/material.dart';

class SpecialOffersWidget extends StatelessWidget {
  final List<String> offers;

  const SpecialOffersWidget({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: offers.map((offer) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(offer),
          ),
        );
      }).toList(),
    );
  }
}
