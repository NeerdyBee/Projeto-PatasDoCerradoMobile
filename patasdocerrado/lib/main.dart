import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/home.dart';
import 'package:patasdocerrado/pages/my_adoptables.dart';
import 'package:patasdocerrado/pages/tela_inicial.dart';
import 'package:patasdocerrado/pages/login.dart';
import 'package:patasdocerrado/pages/register.dart';
import 'package:patasdocerrado/pages/recoverPswd.dart';
import 'package:patasdocerrado/pages/editprofile.dart';
import 'package:patasdocerrado/pages/my_favorites.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        '/editprofile': (context) => const EditProfilePage(),
        '/my_favorites': (context) => const MyFavoritesPage(),
        '/my_adoptables': (context) => const MyAdoptablesPage(),
      },
    );
  }

  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);
    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }
}
