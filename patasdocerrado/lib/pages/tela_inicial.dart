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
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 100),
                    child: Image(
                        image: AssetImage('../assets/logo.png'), height: 125)),
                //
                //TEXTOS
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
                            'Vários pets estão esperando\n            por um novo lar.',
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
                const SizedBox(height: 50),
                //
                //BOTÃO
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 238, 77, 33), // Cor do botão
                    minimumSize: const Size(
                        367, 49), // Define a largura (200) e altura (50)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Arredondamento de 10 nas bordas
                    ),
                  ),
                  child: const Text(
                    'Vamos Começar',
                    style: TextStyle(
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
                //
                //
              ],
            ))));
  }
}
