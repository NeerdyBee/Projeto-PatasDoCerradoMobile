import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Patas do Cerrado"),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
            ),
            //
            //
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(95, 68, 68, 68),
                        spreadRadius: 0.7,
                        blurRadius: 6),
                  ],
                ),
                //
                //
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                    //
                    child: BottomNavigationBar(
                        selectedItemColor: const Color.fromRGBO(255, 97, 62, 1),
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                              color: Color.fromRGBO(255, 97, 62, 1),
                            ),
                            //
                            label: 'Início',
                          ),
                          //
                          BottomNavigationBarItem(
                            icon: Icon(Icons.search),
                            label: 'Adotaveis',
                          ),
                          //
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person_outline),
                            label: 'Perfil',
                          ),
                        ]))),
            //
            //
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(
                    image: NetworkImage(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    height: 200),
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
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.7))),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Vamos Começar'),
                ),
              ],
            ))));
  }
}
