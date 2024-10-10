import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/config.dart';
import 'package:patasdocerrado/pages/home.dart';
import 'package:patasdocerrado/pages/profile.dart';
import 'package:patasdocerrado/pages/tela_inicial.dart';
import 'package:patasdocerrado/pages/login.dart';
import 'package:patasdocerrado/pages/cadastro.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InitialPage(),
      routes: {
        '/initialpage': (context) => const InitialPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
