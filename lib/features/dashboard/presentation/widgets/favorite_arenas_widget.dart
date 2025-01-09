import 'package:flutter/material.dart';

class FavoriteArenasWidget extends StatelessWidget {
  final List<String> favoriteArenas;

  const FavoriteArenasWidget({super.key, required this.favoriteArenas});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: favoriteArenas.map((arena) {
        return ListTile(
          title: Text(arena),
          trailing: const Icon(Icons.favorite, color: Colors.red),
        );
      }).toList(),
    );
  }
}
