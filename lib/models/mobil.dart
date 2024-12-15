class Mobil {
  final String id;
  final String name;
  final String location;
  final String description;
  final String built;
  final String merek;
  final String harga;
  final String tempatduduk;
  final String cc;
  final String bahanbakar;
  final String transmisi;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;

  Mobil({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.built,
    required this.merek,
    required this.harga,
    required this.tempatduduk,
    required this.cc,
    required this.bahanbakar,
    required this.transmisi,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
  });

  }