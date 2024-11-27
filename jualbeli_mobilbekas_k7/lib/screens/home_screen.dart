import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/models/mobil.dart';

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
      appBar: AppBar(title: Text('KOSMAN'),),
      // Todo: 2. Buat body dengan GridView.builder
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          padding: EdgeInsets.all(8),
          itemCount: mobilList.length,
          itemBuilder: (context,index){
            Mobil candi = mobilList[index]; // Ambil candi berdasarkan index
            return ItemCard(mobil: mobil);

          }
        // Todo: 3. Buat ItemCard sebagai return value dari GridView.Builder
      ),
    );
  }
}
