import 'package:flutter/material.dart';
import 'package:patasdocerrado/components/my_appbar.dart';
import 'package:patasdocerrado/components/my_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
//
//INICIALIZAÇÃO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //
        //APP BAR
        appBar: MyAppBar(),
        //
        //BARRA INTERATIVA
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 231, 231, 231),
                    spreadRadius: 0.7,
                    blurRadius: 6),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              //
              //ICONES - BOTOES
              child: MyNavBar(),
            )),
        //
        //IMAGEM - BEM VINDO E BOTÃO
        body: Center(
            child: Column(
          children: [
            const Image(image: AssetImage('logo.png'), height: 200),
            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Bem Vindo!',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Vários pets estão esperando por um novo lar',
                      style: TextStyle(color: Colors.black.withOpacity(0.7))),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Vamos Começar'),
              onPressed: () {
                Navigator.pushNamed(context, '/config');
              },
            ),
          ],
        )));
  }
}