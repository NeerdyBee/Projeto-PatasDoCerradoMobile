import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/initial.dart';
import 'package:patasdocerrado/pages/feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List _pages = [
    const InitialPage(),
    const FeedPage(),
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
        child: CustomBottomNavigationBar(_selectedIndex, _selectPage),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatelessWidget {
  int _selectedIndex = 0;
  ValueChanged<int> _selectPage;
  CustomBottomNavigationBar(this._selectedIndex, this._selectPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          padding: EdgeInsets.only(top: 4.0),
          width: 430,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            backgroundColor: const Color.fromARGB(0, 235, 68, 68),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Adotáveis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            selectedItemColor: Color(0xFFFF623E),
            unselectedItemColor: Color(0xFF6e6f76),
            onTap: _selectPage,
          ),
        )
      ],
    );
  }
}
