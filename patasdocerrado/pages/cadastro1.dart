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
              RichText(
                  text: TextSpan(
                      text: 'Nome',
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
                    hintText: 'Digite seu nome',
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'CPF',
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
                    hintText: 'Digite seu CPF',
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'E-mail',
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
                    hintText: 'Digite seu e-mail',
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Telefone',
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
                    hintText: 'Digite seu telefone',
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Senha',
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
                    hintText: 'Senha',
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Confirmar senha',
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
                    hintText: 'Confirmar senha',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                      foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                      minimumSize: Size(367, 49),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'Próximo passo',
                    style: TextStyle(fontSize: 16),
                  )),
            ])));
  }
}
