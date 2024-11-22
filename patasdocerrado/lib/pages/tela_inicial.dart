import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});
//
//INICIALIZAÇÃO
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            //
            //IMAGEM
            body: Center(
                child: Column(
              children: [
                SizedBox(height: 100),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/logo.png', height: 130)
                    ]),
                SizedBox(height: 120),
                RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Bem Vindo!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Negrito
                          fontSize: 18,
                          color: Color.fromRGBO(22, 24, 35, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                //ESPAÇO
                const SizedBox(height: 6),
                //
                //
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Vários amigos estão esperando\n            por um novo lar.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                //ESPAÇO
                const SizedBox(height: 70),
                //
                //BOTÃO
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: Size(380, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Vamos começar!',
                      style: TextStyle(fontSize: 16),
                    )),
                //
                //
              ],
            ))));
  }
}
