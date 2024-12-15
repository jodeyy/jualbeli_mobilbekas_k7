import 'package:flutter/material.dart';
import 'package:jualbelimobil/data/mobil_data.dart';
import 'package:jualbelimobil/screens/chat_screen.dart';
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
      //routes: {
        //'/signup': (context) => SignUpScreen(),
        //'/signin': (context) => SignInScreen(), // Ganti dengan halaman login Anda
      //},
      //initialRoute: '/signup',

      // home: DetailScreen(),
      // home: ProfileScreen(),
      // home: HomeScreen(),
      //home: ChatScreen(),
      //home: SignInScreen(),
      //home: SignUpScreen(),
       //home: SearchScreen(),
      //home: FavoriteScreen(),
      home: MainScreen(),
      initialRoute: '/',
      routes: {
        '/homescreen' : (context) => const HomeScreen(),
        '/signin' : (context) =>  SignInScreen(),
        '/signup' : (context) =>  SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //deklarasi Variabel
  int _currentIndex = 0;
  
  final List<Widget> _children = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _children[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue[50],
          ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.blue,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.blue,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.blue,),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.blue,),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue[100],
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}


