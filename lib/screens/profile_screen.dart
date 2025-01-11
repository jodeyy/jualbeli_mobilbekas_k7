import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _imageFile = '';
  final picker = ImagePicker();
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  late CameraDescription _camera;
  bool _isCameraInitialized = false;

  String fullName = '';
  String userName = '';
  String email = '';
  String phoneNumber = '';
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadImage();
    _initializeCamera();
  }

  // Menginisialisasi kamera
  Future<void> _initializeCamera() async {
    await Permission.camera.request();
    _cameras = await availableCameras();
    _camera = _cameras.first;

    _controller = CameraController(
      _camera,
      ResolutionPreset.high,
    );

    await _controller.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  // Mengambil foto
  Future<void> _takePicture() async {
    try {
      final XFile picture = await _controller.takePicture();
      debugPrint('Gambar berhasil diambil: ${picture.path}');
      setState(() {
        _imageFile = picture.path;
      });
      _saveImage();
    } catch (e) {
      debugPrint('Error mengambil gambar: $e');
    }
  }

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
                  Navigator.of(context).pop();
                  _takePicture(); // Mengambil gambar langsung dari kamera
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

  Future<void> _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? keyString = prefs.getString('key');
    final String? ivString = prefs.getString('iv');

    if (keyString != null && ivString != null) {
      final key = encrypt.Key.fromBase64(keyString);
      final iv = encrypt.IV.fromBase64(ivString);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      setState(() {
        fullName = encrypter.decrypt64(prefs.getString('name') ?? '', iv: iv);
        userName = encrypter.decrypt64(prefs.getString('username') ?? '', iv: iv);
        email = encrypter.decrypt64(prefs.getString('email') ?? '', iv: iv);
        phoneNumber = encrypter.decrypt64(prefs.getString('notelpon') ?? '', iv: iv);
        isSignedIn = true;
      });
    }
  }

  Future<void> _saveProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? keyString = prefs.getString('key');
    final String? ivString = prefs.getString('iv');

    if (keyString != null && ivString != null) {
      final key = encrypt.Key.fromBase64(keyString);
      final iv = encrypt.IV.fromBase64(ivString);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      prefs.setString('name', encrypter.encrypt(fullName, iv: iv).base64);
      prefs.setString('username', encrypter.encrypt(userName, iv: iv).base64);
      prefs.setString('email', encrypter.encrypt(email, iv: iv).base64);
      prefs.setString('notelpon', encrypter.encrypt(phoneNumber, iv: iv).base64);
    }
  }

  void _editField(String label, String initialValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new $label'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              _saveProfileData();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Fungsi logout yang hanya mengubah status login, tanpa menghapus data lokal
  Future<void> _signOut() async {
    setState(() {
      // Set isSignedIn menjadi false, tetapi data lainnya tetap ada
      isSignedIn = false;
    });

    // Tidak ada penghapusan data dari SharedPreferences
    // Anda dapat tetap menyimpan data pengguna
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                Divider(color: Colors.blue[100]),
                _buildEditableRow('Nama', fullName, Icons.person, (value) => setState(() => fullName = value)),
                Divider(color: Colors.blue[100]),
                _buildEditableRow('Username', userName, Icons.account_box, (value) => setState(() => userName = value)),
                Divider(color: Colors.blue[100]),
                _buildEditableRow('Email', email, Icons.email, (value) => setState(() => email = value)),
                Divider(color: Colors.blue[100]),
                _buildEditableRow('Telepon', phoneNumber, Icons.phone, (value) => setState(() => phoneNumber = value)),
                const SizedBox(height: 20),
                Divider(color: Colors.blue[100]),
                TextButton(
                  onPressed: isSignedIn ? _signOut : () => Navigator.pushNamed(context, '/signin'),
                  child: Text(isSignedIn ? 'Logout' : 'Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, String value, IconData icon, Function(String) onSave) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 8),
            Text('$label: $value', style: const TextStyle(fontSize: 18)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () => _editField(label, value, onSave),
        ),
      ],
    );
  }
}
