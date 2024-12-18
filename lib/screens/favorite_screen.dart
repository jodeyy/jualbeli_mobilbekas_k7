import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jualbelimobil/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jualbelimobil/models/mobil.dart';
import 'package:jualbelimobil/data/mobil_data.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Mobil> favoriteList = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_mobils') ?? [];

    setState(() {
      favoriteList = mobilList
          .where((mobil) => favoriteIds.contains(mobil.id.toString()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite Mobil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: favoriteList.isEmpty ? const Center(
        child: Text(
          "Favorite tidak ditemukan",
          style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.w200),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
          itemCount: favoriteList.length,
          itemBuilder: (context, index) {
            final mobil = favoriteList[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    mobil.imageAsset,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  mobil.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  mobil.harga,
                  style:
                  const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final favoriteIds =
                        prefs.getStringList('favorite_mobils') ?? [];
                    favoriteIds.remove(mobil.id.toString());
                    await prefs.setStringList('favorite_mobils', favoriteIds);

                    setState(() {
                      favoriteList.removeAt(index);
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(mobil: mobil),
                      ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}