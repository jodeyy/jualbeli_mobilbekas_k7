import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/models/mobil.dart';
import 'package:jualbelimobil/widget/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Todo: 1 Buat appbar dengan judul wisata Candi
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: Text('Mobil Bekas Murah',
        style: TextStyle(
          fontFamily: 'Arial', // Mengganti font ke Arial
          fontSize: 24, // Mengubah ukuran font
          fontWeight: FontWeight.bold, // Mengubah ketebalan font
          color: Colors.white, // Mengubah warna font
        ),
      ),
      backgroundColor: Colors.blue,
      ),
      // Todo: 2. Buat body dengan GridView.builder
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          padding: EdgeInsets.all(8),
          itemCount: mobilList.length,
          itemBuilder: (context,index){
            Mobil mobil = mobilList[index]; // Ambil candi berdasarkan index
            return ItemCard(mobil: mobil);

          }
        // Todo: 3. Buat ItemCard sebagai return value dari GridView.Builder
      ),
    );
  }
}
