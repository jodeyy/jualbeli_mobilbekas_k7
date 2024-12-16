import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variabel profil
  String _imageFile = '';
  final picker = ImagePicker();

  Future<void> _saveImage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', _imageFile);
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageFile = prefs.getString('imagePath') ?? '';
    });
  }

  Future<void> _getImage(ImageSource source) async {
    if (kIsWeb && source == ImageSource.camera) {
      debugPrint('Kamera tidak didukung di Web. Gunakan perangkat fisik.');
      return;
    }

    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxHeight: 720,
        maxWidth: 720,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile.path;
        });
        _saveImage();
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.indigo[50],
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_enhance, color: Colors.blue),
                title: const Text('Camera'),
                onTap: () {
                  debugPrint('Kamera dipanggil');
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  String email = '';
  String phoneNumber = '';

  // Fungsi untuk mendekripsi data dari SharedPreferences
  Future<void> _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? keyString = prefs.getString('key'); // Ambil kunci enkripsi
    final String? ivString = prefs.getString('iv'); // Ambil IV enkripsi

    if (keyString != null && ivString != null) {
      final key = encrypt.Key.fromBase64(keyString);
      final iv = encrypt.IV.fromBase64(ivString);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      // Dekripsi setiap data yang terenkripsi
      setState(() {
        fullName = encrypter.decrypt64(prefs.getString('name') ?? '', iv: iv);
        userName = encrypter.decrypt64(prefs.getString('username') ?? '', iv: iv);
        email = encrypter.decrypt64(prefs.getString('email') ?? '', iv: iv);
        phoneNumber = encrypter.decrypt64(prefs.getString('notelpon') ?? '', iv: iv);
        isSignedIn = fullName.isNotEmpty && userName.isNotEmpty;
      });
    } else {
      // Jika tidak ada data terenkripsi, set profil kosong
      setState(() {
        isSignedIn = false;
      });
    }
  }

  // Fungsi Sign Out
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data saat sign out
    setState(() {
      isSignedIn = false;
      fullName = '';
      userName = '';
      email = '';
      phoneNumber = '';
      _imageFile = '';
    });
    Navigator.pushReplacementNamed(context, '/signin');
  }

  // Navigasi ke halaman Sign In
  void signIn() {
    Navigator.pushNamed(context, '/signin');
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Muat data saat layar dibuka
    _loadImage(); // Muat gambar profil saat layar dibuka
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Gambar Profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _imageFile.isNotEmpty
                                ? (kIsWeb
                                ? NetworkImage(_imageFile)
                                : FileImage(File(_imageFile))) as ImageProvider
                                : const AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt_outlined, color: Colors.blue),
                          onPressed: _showPicker,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Informasi Profil
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Nama', fullName, Icons.person, isSignedIn),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Username', userName, Icons.account_box, isSignedIn),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Email', email, Icons.email, isSignedIn),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Telepon', phoneNumber, Icons.phone, isSignedIn),
                const SizedBox(height: 20),
                // Tombol Sign In/Out
                isSignedIn
                    ? TextButton(
                      onPressed: signOut,
                      child: const Text('Sign Out'),
                )
                    : TextButton(
                      onPressed: signIn,
                      child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat baris profil
  Widget _buildProfileRow(String label, String value, IconData icon, bool isEditable) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Text(': $value', style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
