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
      // Background dengan warna gradien
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Mobil Murah +',
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: EdgeInsets.all(8),
        itemCount: mobilList.length,
        itemBuilder: (context, index) {
          Mobil mobil = mobilList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ItemCard(mobil: mobil),
          );
        },
      ),
    );
  }
}
