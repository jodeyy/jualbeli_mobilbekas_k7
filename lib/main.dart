import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/screens/detail_screen.dart';
import 'package:jualbelimobil/screens/home_screen.dart';
import 'package:jualbelimobil/screens/search_screen.dart';
import 'package:jualbelimobil/screens/login_screen.dart';
import 'package:jualbelimobil/screens/register_screen.dart';
import 'package:jualbelimobil/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jual Mobil Bekas Murah Meriah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Menambahkan routing untuk berbagai halaman
      initialRoute: '/login', // Halaman awal adalah Login
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen(),

      },
      // home: DetailScreen(),
      // home: ProfileScreen(),
      // home: HomeScreen(),
      //home: LoginPage(),
      //home: RegisterPage(),
       //home: SearchScreen(),
    );
  }
}

