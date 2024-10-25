import 'package:flutter/material.dart';
import 'package:patasdocerrado/components/my_navbar.dart';
import 'package:patasdocerrado/pages/initial.dart';
import 'package:patasdocerrado/pages/adoptables.dart';
import 'package:patasdocerrado/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List _pages = [
    const InitialPage(),
    const AdoptablesPage(),
    const ProfilePage()
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: MyNavbar(_selectedIndex, _selectPage),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

// ignore: must_be_immutable
