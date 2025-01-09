import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  final VoidCallback onOpenMap;

  const MapWidget({super.key, required this.onOpenMap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenMap,
      child: Container(
        height: 200,
        color: Colors.blueAccent,
        child: const Center(
          child: Text(
            "Map View",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
