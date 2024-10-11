import 'package:flutter/material.dart';

class RecoverPswdNewPage extends StatelessWidget {
  const RecoverPswdNewPage({super.key});
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
                          text: 'Crie sua nova senha!\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 4)),
                      TextSpan(
                          text: 'Digite sua nova senha, e confirme.',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Nova senha',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirmar nova senha',
                    ),
                  ),
                ),
                //
                //ESPAÇAMENTO
                SizedBox(height: 30),
                //
                //
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: Size(445, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Concluir e redefinir senha',
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            )));
  }
}
