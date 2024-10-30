import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/home.dart';
import 'package:patasdocerrado/pages/tela_inicial.dart';
import 'package:patasdocerrado/pages/login.dart';
import 'package:patasdocerrado/pages/register.dart';
import 'package:patasdocerrado/pages/recoverPswd.dart';
import 'package:patasdocerrado/pages/recoverPswdCode.dart';
import 'package:patasdocerrado/pages/recoverPswdNew.dart';
import 'package:patasdocerrado/pages/editprofile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'BS70Hl8xgdpi1EQGC3BqWKOZBoAwSqH2erMgpg6z';
  const keyClientKey = '9MJ87n7THIRB5ueD60MR4nsG2JYJ6og5USoMFnM8';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
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
