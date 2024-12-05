import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SharedPrefHelper {
  // Kunci untuk SharedPreferences
  static const String _keyUsername = 'username';
  static const String _keyFullName = 'full_name';
  static const String _keyEmail = 'email';
  static const String _keyPhone = 'phone';
  static const String _keyPassword = 'password';

  // Fungsi untuk menyimpan data pengguna di SharedPreferences
  static Future<void> saveUser({
    required String username,
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Simpan data pengguna
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyFullName, fullName);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPhone, phone);

    // Enkripsi password dan simpan
    String encryptedPassword = encryptPassword(password);
    await prefs.setString(_keyPassword, encryptedPassword);

    print("User data saved:");
    print("Username: $username");
    print("Full Name: $fullName");
    print("Email: $email");
    print("Phone: $phone");
    print("Encrypted Password: $encryptedPassword");
  }

  // Fungsi untuk mengambil data pengguna dari SharedPreferences
  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil data pengguna dan kembalikan dalam bentuk Map
    String? username = prefs.getString(_keyUsername);
    String? fullName = prefs.getString(_keyFullName);
    String? email = prefs.getString(_keyEmail);
    String? phone = prefs.getString(_keyPhone);
    String? password = prefs.getString(_keyPassword);

    print("Fetched user data:");
    print("Username: $username");
    print("Full Name: $fullName");
    print("Email: $email");
    print("Phone: $phone");
    print("Encrypted Password: $password");

    return {
      'username': username,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  // Fungsi untuk mengenkripsi password
  static String encryptPassword(String password) {
    final key = encrypt.Key.fromUtf8('32charactersecretkey12345678901234'); // 32 karakter -> 256 bit
    final iv = encrypt.IV.fromLength(16); // IV berukuran 16 byte
    final encrypter = encrypt.Encrypter(encrypt.AES(key)); // menggunakan AES

    final encrypted = encrypter.encrypt(password, iv: iv); // enkripsi password
    return encrypted.base64; // mengembalikan password yang telah terenkripsi
  }

  // Fungsi untuk mendekripsi password yang terenkripsi
  static String decryptPassword(String encryptedPassword) {
    final key = encrypt.Key.fromUtf8('32charactersecretkey12345678901234'); // 32 karakter -> 256 bit
    final iv = encrypt.IV.fromLength(16); // IV berukuran 16 byte
    final encrypter = encrypt.Encrypter(encrypt.AES(key)); // enkriptor AES

    final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv); // dekripsi password
    return decrypted; // mengembalikan password yang telah didekripsi
  }

  // Fungsi untuk mendapatkan username yang tersimpan
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(_keyUsername);
    print("Fetched Username: $username");
    return username;
  }

  // Fungsi untuk mendapatkan password yang tersimpan
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString(_keyPassword);
    print("Fetched Password: $password");
    return password;
  }

  // Fungsi untuk memeriksa apakah pengguna sudah terdaftar
  static Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.containsKey(_keyUsername) && prefs.containsKey(_keyPassword);
    print("Is user registered: $isRegistered");
    return isRegistered;
  }
}
