import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/screens/detail_screen.dart';
import 'package:jualbelimobil/screens/home_screen.dart';
import 'package:jualbelimobil/screens/search_screen.dart';
import 'package:jualbelimobil/screens/signin_screen.dart';
import 'package:jualbelimobil/screens/signup_screen.dart';
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
      title: 'Aplikasi Jual Mobil Second',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: DetailScreen(),
      // home: ProfileScreen(),
      // home: HomeScreen(),
      // home: SigninScreen(),
      home: SignUpScreen(),
      // home: SearchScreen(),
    );
  }
}

