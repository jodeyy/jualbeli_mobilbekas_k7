import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/screens/detail_screen.dart';
import 'package:jualbelimobil/screens/favorite_screen.dart';
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
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/signin': (context) => SignInScreen(), // Ganti dengan halaman login Anda
      },
      initialRoute: '/signup',

      // home: DetailScreen(),
      // home: ProfileScreen(),
      //home: HomeScreen(),
      //home: SignInScreen(),
      //home: SignUpScreen(),
       //home: SearchScreen(),
      //home: FavoriteScreen(),
    );
  }
}

