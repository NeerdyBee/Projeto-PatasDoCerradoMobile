// ignore_for_file: prefer_const_constructors

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
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                      foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                      minimumSize: Size(367, 49),
                      maximumSize: Size(367, 49),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Próximo passo',
                    style: TextStyle(fontSize: 16),
                  )),
            ),
            //
            //APP BAR
            appBar: AppBar(
              leading: Icon(Icons.arrow_back_ios_rounded),
              title: Text('Cadastro'),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
            ),
            //IMAGEM - BEM VINDO E BOTÃO
            body: Column(children: [
              CircleAvatar(
                backgroundColor: Color(0xffE6E6E6),
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 90,
                  color: Color(0xffCCCCCC),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Insira uma foto de perfil\n',
                      style: TextStyle(
                        fontSize: 16,
                        height: 2,
                      ))),
              RichText(
                  text: TextSpan(
                      text: 'Nome de Usuário',
                      style: TextStyle(
                        fontSize: 16,
                        height: 2,
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Digite seu nome de usuário',
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Cidade',
                      style: TextStyle(
                        fontSize: 16,
                        height: 2,
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Sua Cidade',
                  ),
                ),
              ),
            ])));
  }
}
