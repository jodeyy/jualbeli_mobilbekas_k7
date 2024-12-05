import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/shared_pref_helper.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? fullNameError;
  String? emailError;
  String? phoneError;
  String? passwordError;

  // Fungsi validasi Nama Lengkap
  bool validateFullName(String name) {
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$'); // Hanya huruf dan spasi
    if (!nameRegExp.hasMatch(name)) {
      setState(() {
        fullNameError = "Nama lengkap hanya boleh huruf!";
      });
      return false;
    }
    setState(() {
      fullNameError = null;
    });
    return true;
  }

  // Fungsi validasi Email
  bool validateEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(email)) {
      setState(() {
        emailError = "Email tidak valid!";
      });
      return false;
    }
    setState(() {
      emailError = null;
    });
    return true;
  }

  // Fungsi validasi Nomor Telepon
  bool validatePhone(String phone) {
    final phoneRegExp = RegExp(r'^[0-9]+$'); // Hanya angka
    if (!phoneRegExp.hasMatch(phone)) {
      setState(() {
        phoneError = "Nomor telepon hanya boleh angka!";
      });
      return false;
    }
    setState(() {
      phoneError = null;
    });
    return true;
  }

  // Fungsi validasi Password
  bool validatePassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$'); // Harus ada huruf dan angka, minimal 8 karakter
    if (!passwordRegExp.hasMatch(password)) {
      setState(() {
        passwordError = "Password harus mengandung huruf, angka, dan minimal 8 karakter!";
      });
      return false;
    }
    setState(() {
      passwordError = null;
    });
    return true;
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
                  "Daftar Akun Baru",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              // Field Nama Lengkap
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  errorText: fullNameError,
                ),
                onChanged: (value) {
                  validateFullName(value);
                },
              ),
              SizedBox(height: 15),
              // Field Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  errorText: emailError,
                ),
                onChanged: (value) {
                  validateEmail(value);
                },
              ),
              SizedBox(height: 15),
              // Field Nomor Telepon
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  errorText: phoneError,
                ),
                onChanged: (value) {
                  validatePhone(value);
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
              // Tombol Daftar di Tengah
              Center(
                child: TextButton(
                  onPressed: () {
                    // Validasi saat menekan tombol daftar
                    if (validateFullName(fullNameController.text) &&
                        validateEmail(emailController.text) &&
                        validatePhone(phoneController.text) &&
                        validatePassword(passwordController.text)) {
                      String encryptedPassword = SharedPrefHelper.encryptPassword(passwordController.text);

                      SharedPrefHelper.saveUser(
                        username: emailController.text,
                        fullName: fullNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        password: encryptedPassword,
                      );

                      Navigator.pop(context); // Kembali ke halaman login setelah berhasil
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
                    "Daftar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Tombol untuk kembali ke halaman login
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman login
                  },
                  child: Text(
                    "Sudah punya akun? Login di sini",
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
