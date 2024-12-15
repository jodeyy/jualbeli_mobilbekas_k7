import 'package:flutter/material.dart';
import 'package:jualbelimobil/screens/detail_screen.dart';

import '../models/mobil.dart';


class ItemCard extends StatelessWidget {
  // Todo : 1. Deklarasikan variabel yang dibutuhkan dan pasang pada konstruktor
  final Mobil mobil;
  const ItemCard({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    // TODO: 6. Implementasi routing ke DetailScreen
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(mobil: mobil),
          ),
        );
      },
      child: Card(
        // TODO: 2. Tetapkan parameter shape, margin, dan elavation dari cari
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(4),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: 3. buat Image sebagai anak dari column
            Expanded(
              // TODO: 7. Implementasi Hero Animation
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  mobil.imageAsset,
                  width: double.infinity,
                  fit: BoxFit.cover,

                ),
              ),
            ),

            // TODO:4. Buat Text sebagai anak dari column
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Row(
                  children: [
                  Icon(Icons.directions_car, size: 16, color: Colors.blue),
              SizedBox(width: 4),
                    Expanded( // Membungkus teks dengan Expanded
                      child: Text(
                        mobil.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey[800],
                        ),
                        overflow: TextOverflow.ellipsis, // Menambahkan ellipsis jika teks terlalu panjang
                      ),
                    ),
                  ],
              ),
            ),
            // TODO:5. Buat Text Sebagai anak dari column
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Row(
                  children: [
                    Icon(Icons.monetization_on_outlined, size: 14, color: Colors.green),
                    SizedBox(width: 4),
                    Expanded(child:
                    Text(
                      mobil.harga,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.green[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Row(
                  children: [
                  Icon(Icons.label, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Expanded(child:
              Text(
                mobil.merek,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              ),
            ]),
            ),
          ],
        ),
      ),
    );
  }
}
