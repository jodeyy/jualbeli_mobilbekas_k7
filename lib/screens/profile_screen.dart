import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  String email = '';
  String phoneNumber = '';
  int favoriteMobilCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSignedIn = prefs.getBool('isSignedIn') ?? false;
      fullName = prefs.getString('name') ?? '';
      userName = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      phoneNumber = prefs.getString('notelpon') ?? '';
      favoriteMobilCount = prefs.getInt('favoriteMobilCount') ?? 0;
    });
  }

  void signIn() {
    Navigator.pushNamed(context, '/signin');
  }

  void signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);
    setState(() {
      isSignedIn = false;
    });
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage('images/placeholder_image.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Pengguna', userName, Icons.lock),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Nama', fullName, Icons.person),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Email', email, Icons.email),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Telepon', phoneNumber, Icons.phone),
                Divider(color: Colors.blue[100]),
                _buildProfileRow('Favorite', '$favoriteMobilCount', Icons.favorite),
                const SizedBox(height: 20),
                Divider(color: Colors.blue[100]),
                isSignedIn
                    ? TextButton(onPressed: signOut, child: const Text('Sign Out'))
                    : TextButton(onPressed: signIn, child: const Text('Sign In')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String title, String value, IconData icon) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            ': $value',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
