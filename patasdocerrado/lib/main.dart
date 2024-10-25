import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/home.dart';
import 'package:patasdocerrado/pages/tela_inicial.dart';
import 'package:patasdocerrado/pages/login.dart';
import 'package:patasdocerrado/pages/register.dart';
import 'package:patasdocerrado/pages/recoverPswd.dart';
import 'package:patasdocerrado/pages/recoverPswdCode.dart';
import 'package:patasdocerrado/pages/recoverPswdNew.dart';
import 'package:patasdocerrado/pages/editprofile.dart';

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
        '/registerpage': (context) => const RegisterPage(),
        '/homepage': (context) => const HomePage(),
        '/recoverpswdpage': (context) => const RecoverPswdPage(),
        '/recoverpswdcodepage': (context) => const RecoverPswdCodePage(),
        '/recoverpswdnewpage': (context) => const RecoverPswdNewPage(),
        '/editprofile': (context) => const EditProfilePage(),
      },
    );
  }
}
