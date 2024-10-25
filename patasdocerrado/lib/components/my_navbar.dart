import 'package:flutter/material.dart';

class MyNavbar extends StatelessWidget {
  int _selectedIndex = 0;
  ValueChanged<int> _selectPage;
  MyNavbar(this._selectedIndex, this._selectPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
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
          backgroundColor: Colors.transparent,
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
    ]);
  }
}
