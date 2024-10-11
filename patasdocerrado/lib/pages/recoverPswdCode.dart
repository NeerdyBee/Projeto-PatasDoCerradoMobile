import 'package:flutter/material.dart';

class RecoverPswdCodePage extends StatelessWidget {
  const RecoverPswdCodePage({super.key});
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
                    child: Image(image: AssetImage('logo.png'), height: 125)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Digite o codigo\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 4)),
                      TextSpan(
                          text:
                              'Insira o codigo enviado ao seu e-mail\n cadastrado.',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 67, vertical: 30),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '000-000',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/recoverpswdnewpage'),
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
              ],
            )));
  }
}
