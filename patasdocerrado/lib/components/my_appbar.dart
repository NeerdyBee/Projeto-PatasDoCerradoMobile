import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'logo.png',
        height: 50, // Ajuste a altura conforme necessário
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
