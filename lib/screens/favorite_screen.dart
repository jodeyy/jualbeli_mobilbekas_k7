import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter mobil yang isFavorite == true
    final favoriteMobils = mobilList.where((mobil) => mobil.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobil Favorit'),
      ),
      body: favoriteMobils.isEmpty
          ? Center(child: Text('Belum ada mobil favorit'))
          : ListView.builder(
        itemCount: favoriteMobils.length,
        itemBuilder: (context, index) {
          final mobil = favoriteMobils[index];
          return ListTile(
            title: Text(mobil.name),
            subtitle: Text(mobil.location),
            trailing: Icon(Icons.favorite, color: Colors.red),
          );
        },
      ),
    );
  }
}
