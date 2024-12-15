import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variabel profil
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  String email = '';
  String phoneNumber = '';

  // Fungsi untuk mengambil data dari SharedPreferences
  Future<void> _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('name') ?? '';
      userName = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      phoneNumber = prefs.getString('notelpon') ?? '';
      isSignedIn = fullName.isNotEmpty && userName.isNotEmpty;
    });
  }

  // Fungsi Sign Out
  void signOut() {
    // async final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear(); // Menghapus semua data saat sign out
    // setState(() {
    //   isSignedIn = false;
    //   fullName = '';
    //   userName = '';
    //   email = '';
    //   phoneNumber = '';
    // });
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
                            backgroundImage:
                            AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt, color: Colors.blue[50]),
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Informasi Profil
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Nama', fullName, Icons.person, isSignedIn),
                Divider(color: Colors.blue[100]),
                _buildProfileRow(
                    'Username', userName, Icons.account_box, isSignedIn),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Email', email, Icons.email, isSignedIn),
                Divider(color: Colors.blue[100]),
                _buildProfileRow(
                    'Telepon', phoneNumber, Icons.phone, isSignedIn),
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Expanded(
          child: Text(': $value', style: const TextStyle(fontSize: 18)),
        ),
        if (isEditable) const Icon(Icons.edit),
      ],
    );
  }
}
