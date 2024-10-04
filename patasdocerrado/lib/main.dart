import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/config.dart';
import 'package:patasdocerrado/pages/home.dart';
import 'package:patasdocerrado/pages/profile.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/config': (context) => const ConfigPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
