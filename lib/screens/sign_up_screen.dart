import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _obscurePassword = true;

  void _signup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = _nameController.text.trim();
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String notelpon = _nomorController.text.trim();
    final String password = _passwordController.text.trim();

    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#%^&*()-_=+{}]'))) {
      setState(() {
        _errorText =
        'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#%^&*()-_=+{}]';
      });
      return;
    }

    if (name.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
      final encrypt.Key key = encrypt.Key.fromLength(32);
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encryptedName = encrypter.encrypt(name, iv: iv);
      final encryptedUsername = encrypter.encrypt(username, iv: iv);
      final encryptedPassword = encrypter.encrypt(password, iv: iv);

      prefs.setString('name', encryptedName.base64);
      prefs.setString('username', encryptedUsername.base64);
      prefs.setString('notelpon', encryptedPassword.base64);
      prefs.setString('password', encryptedPassword.base64);
      prefs.setString('key', key.base64);
      prefs.setString('iv', iv.base64);
    }

    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _nomorController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Nama Lengkap
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Username
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.account_box),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // No Telpon
                        TextFormField(
                          controller: _nomorController,
                          decoration: InputDecoration(
                            labelText: 'No Telpon',
                            border: OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.phone),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Password
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: _errorText.isNotEmpty ? _errorText : null,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          obscureText: _obscurePassword,
                        ),
                        const SizedBox(height: 20),
                        // Tombol DAFTAR
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: _signup,
                          child: const Text('DAFTAR'),
                        ),
                        const SizedBox(height: 8),
                        // RichText untuk Login
                        RichText(
                          text: TextSpan(
                            text: 'Sudah Memiliki Akun?',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Login disini!',
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/signin');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
