import 'package:flutter/material.dart';
import 'package:jualbelimobil/models/mobil.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Deklarasikan variabel yang dibutuhkan
  List<Mobil> _filteredMobils = mobilList;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan judul pencarian mobil
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Cari Mobil Impianmu',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      // Body berupa Column
      body: Column(
        children: [
          // TextField sebagai anak dari Column
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),
              child: TextField(
                autofocus: false,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.toLowerCase();
                    _filteredMobils = mobilList.where((mobil) {
                      return mobil.name.toLowerCase().contains(_searchQuery);
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'mobil...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          // ListView hasil pencarian sebagai anak dari Column
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMobils.length,
              itemBuilder: (context, index) {
                final mobil = _filteredMobils[index];
                return InkWell(
                    onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(mobil: mobil),
                    ),
                  );
                },
                child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // Gambar mobil
                Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      mobil.imageAsset,
                fit: BoxFit.cover, // Pastikan gambar tidak overflow
                ),
                ),
                ),
                // Informasi mobil
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mobil.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis, // Batasi teks
                ),
                SizedBox(height: 4),
                    Text(
                      mobil.merek,
                      style: TextStyle(
                        color: Colors.grey[700],
                ),
                overflow: TextOverflow.ellipsis, // Batasi teks
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                );

              },
            ),
          ),

        ],
      ),
    );
  }
}
