import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Patas do Cerrado"),
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        bottomNavigationBar:
            BottomNavigationBar(backgroundColor: Colors.orange, items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ]),
        drawer: const Drawer(
          backgroundColor: Colors.white,
          child: DrawerHeader(
              child: Icon(
            Icons.favorite,
            size: 48,
          )),
        ),
      ),
    );
  }
}
