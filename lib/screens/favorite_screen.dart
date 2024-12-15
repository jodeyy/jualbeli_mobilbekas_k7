import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';

class FavoriteScreen extends StatelessWidget {
  final List<String> favoriteItems;

  FavoriteScreen({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cars'),
      ),
      body: favoriteItems.isEmpty
          ? Center(child: Text('Belum ada mobil favorit.'))
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.car_rental, color: Colors.blue),
            title: Text(favoriteItems[index]),
          );
        },
      ),
    );
  }
}
