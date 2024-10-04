import 'package:flutter/material.dart';

class MyNavBar extends StatelessWidget implements PreferredSizeWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(255, 97, 62, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(255, 97, 62, 1),
            ),
            //
            label: 'Início',
          ),
          //
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Adotaveis',
          ),
          //
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
