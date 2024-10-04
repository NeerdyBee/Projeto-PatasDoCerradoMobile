// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
            body: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                    child: Image(image: AssetImage('logo.png'), height: 130)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Que bom te ver por aqui!\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              height: 4)),
                      TextSpan(
                          text: 'Econtre seu novo amigo',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'E-mail',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Senha',
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Esqueceu sua senha?\n',
                          style: TextStyle(
                              fontSize: 14,
                              height: 2,
                              color: Color.fromRGBO(255, 97, 62, 1)))
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: Size(445, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 16),
                    )),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Ainda não possui uma conta?',
                          style: TextStyle(
                              fontSize: 14,
                              height: 4,
                              color: Color.fromRGBO(0, 0, 0, 0.5))),
                      TextSpan(
                          text: 'Crie agora!',
                          style: TextStyle(
                              fontSize: 14,
                              height: 4,
                              color: Color.fromRGBO(255, 97, 62, 1)))
                    ],
                  ),
                ),
              ],
            )));
  }
}