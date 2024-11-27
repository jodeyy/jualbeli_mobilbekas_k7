class Mobil {
  final String name;
  final String location;
  final String description;
  final String built;
  final String merek;
  final String harga;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;

  Mobil({
    required this.name,
    required this.location,
    required this.description,
    required this.built,
    required this.merek,
    required this.harga,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
  });

  }