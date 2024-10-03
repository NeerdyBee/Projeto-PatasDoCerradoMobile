// ignore_for_file: prefer_const_constructors
// Nesta pasta vamos estar criando e desenvolvendo as telas
// Para rodar os arquivos criados aqui basta substituir o código do arquivo main.dart pelos da tela que quiser
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
//
//INICIALIZAÇÃO
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
        ));
  }
}
