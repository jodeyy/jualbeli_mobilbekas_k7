import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jualbelimobil/screens/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mobil.dart';

class DetailScreen extends StatefulWidget {
  final Mobil mobil;

  const DetailScreen({super.key, required this.mobil});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  // Fungsi untuk menyimpan mobil favorit ke SharedPreferences
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_mobils') ?? [];

    if (isFavorite) {
      // Jika sudah di-favorite, hapus dari daftar
      favorites.remove(widget.mobil.id.toString());
    } else {
      // Jika belum di-favorite, tambahkan ke daftar
      favorites.add(widget.mobil.id.toString());
    }

    await prefs.setStringList('favorite_mobils', favorites);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  // Fungsi untuk memeriksa apakah makanan ini sudah di-favorite
  Future<void> _checkFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_mobils') ?? [];

    setState(() {
      isFavorite = favorites.contains(widget.mobil.id.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus(); // Periksa status favorite saat pertama kali
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengubah latar belakang seluruh halaman

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[100]!, // Warna biru muda di atas
              Colors.blue[50]!,  // Biru lebih pucat di bawah
            ],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              // DetailHeader
              Stack(
                children: [
                  // image Utama
                  Hero(
                    tag: widget.mobil.imageAsset,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.mobil.imageAsset,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // tombol back kustom
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100]?.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Detail Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    // info atas (nama mobil dan tombol favorite)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.mobil.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            isFavorite
                                ?Icons.favorite
                                :Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,

                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.place, color: Colors.red),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Lokasi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.location}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, color: Colors.blue),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Tahun Beli',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.built}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.branding_watermark_outlined, color: Colors.brown),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Merek',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.merek}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.price_check, color: Colors.green),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Harga',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.harga}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.chair, color: Colors.black54),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Tempat Duduk',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.tempatduduk}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.speed, color: Colors.red[300]),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'CC',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.cc}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.local_gas_station, color: Colors.amber[200]),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Bahan Bakar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.bahanbakar}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.handshake, color: Colors.black12),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Transmisi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.mobil.transmisi}'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(color: Colors.deepPurple.shade100),
                    SizedBox(height: 16),
                    // info bawah (deskripsi)
                    Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(' ${widget.mobil.description}'),
                  ],
                ),
              ),
              //detail galeri
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.deepPurple.shade100),
                    Text(
                      'Galeri',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.mobil.imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context)=> Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: InteractiveViewer(
                                          panEnabled: true, // Aktifkan geser
                                          minScale: 0.5, // Skala minimal zoom
                                          maxScale: 4.0, // Skala maksimal zoom
                                          child: CachedNetworkImage(
                                            imageUrl: widget.mobil.imageUrls[index],
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) => Container(
                                              color: Colors.deepPurple[50],
                                              width: 300,
                                              height: 300,
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          )
                                      ),

                                    )
                                );

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.deepPurple.shade100,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.mobil.imageUrls[index],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.deepPurple[50],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity, // Lebarkan tombol ke ujung layar
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(), // Halaman Chat
                            ),
                          );
                        },
                        icon: Icon(Icons.chat, color: Colors.white),
                        label: Text('Chat Admin'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}