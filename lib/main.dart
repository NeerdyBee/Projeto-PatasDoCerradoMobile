// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 128, 134, 182),
        appBar: AppBar(
          title: Text("Testezito"),
          backgroundColor: const Color.fromARGB(255, 255, 237, 159),
          elevation: 0,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
        ),
        /* -----
  Utilizamos a tag bottomNavigationBar, para construir
----- */
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(
                255, 255, 237, 159), //Podemos mudar a cor de fundo
            items: [
              //Utilizamos a estrutura items: [] para adiconar os itens
              //Home
              BottomNavigationBarItem(
                //Cada item é adicionado com essa tag
                icon: Icon(Icons.home), //podemos trocar os icones
                label: 'Home', //e a label
              ),
              //Perfil
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
              //Configurações
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configurações',
              ),
            ]),
        drawer: Drawer(
          backgroundColor:
              Color.fromARGB(255, 255, 237, 159), //Podemos mudar a cor de fundo
          child: DrawerHeader(
              //podemos adicionar o cabeçalho como um 'filho' do Drawer
              child: Icon(
            Icons.celebration_sharp,
            size: 48,
          )),
        ),
      ),
    );
  }
}
