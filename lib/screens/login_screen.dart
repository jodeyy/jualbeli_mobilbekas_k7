import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/shared_pref_helper.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;

  // Fungsi validasi Nama Pengguna
  bool validateUsername(String username) {
    if (username.isEmpty) {
      setState(() {
        usernameError = "Nama Pengguna tidak boleh kosong!";
      });
      return false;
    }
    setState(() {
      usernameError = null;
    });
    return true;
  }

  // Fungsi validasi Password
  bool validatePassword(String password) {
    if (password.isEmpty) {
      setState(() {
        passwordError = "Password tidak boleh kosong!";
      });
      return false;
    }
    setState(() {
      passwordError = null;
    });
    return true;
  }

  // Fungsi untuk login
  void loginUser() async {
    final username = usernameController.text;
    final password = passwordController.text;

    // Mendapatkan data pengguna yang terdaftar
    String? storedUsername = await SharedPrefHelper.getUsername();  // Menambahkan await untuk mendapatkan data asinkron
    String? storedPassword = await SharedPrefHelper.getPassword();  // Menambahkan await untuk mendapatkan data asinkron

    // Cek apakah username dan password cocok
    if (storedUsername != null && storedPassword != null) {
      // Decrypt password yang tersimpan
      String decryptedPassword = SharedPrefHelper.decryptPassword(storedPassword);

      if (username == storedUsername && password == decryptedPassword) {
        Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke halaman home
      } else {
        setState(() {
          passwordError = "Nama pengguna atau password salah!";
        });
      }
    } else {
      setState(() {
        passwordError = "Akun tidak ditemukan!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Login ke Akun Anda",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              // Field Nama Pengguna
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Nama Pengguna",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  errorText: usernameError,
                ),
                onChanged: (value) {
                  validateUsername(value);
                },
              ),
              SizedBox(height: 15),
              // Field Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  errorText: passwordError,
                ),
                onChanged: (value) {
                  validatePassword(value);
                },
              ),
              SizedBox(height: 20),
              // Tombol Login di Tengah
              Center(
                child: TextButton(
                  onPressed: () {
                    if (validateUsername(usernameController.text) &&
                        validatePassword(passwordController.text)) {
                      loginUser();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    minimumSize: Size(150, 50), // Ukuran tombol agak lebih besar
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Tautan untuk menuju halaman Register
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register'); // Navigasi ke halaman register
                  },
                  child: Text(
                    "Belum punya akun? Daftar di sini",
                    style: TextStyle(color: Colors.blue), // Warna biru
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
