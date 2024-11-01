// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
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
                SizedBox(height: 60),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Image.asset('logo.png', height: 130)]),
                SizedBox(height: 60),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Que bom te ver por aqui!\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      TextSpan(
                          text: 'Encontre seu novo amigo',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(0.5),
                              height: 2)),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.0),
                    ),
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xff8d8d8d))),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.0),
                    ),
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xff8d8d8d))),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/recoverpswdpage'),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 97, 62, 1),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ))),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/homepage'),
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
                SizedBox(height: 30),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/registerpage'),
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Ainda não possui uma conta? ",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16)),
                                TextSpan(
                                    text: "Crie agora!",
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 97, 62, 1),
                                        fontSize: 16))
                              ],
                            ),
                          ),
                        ))),
              ],
            )));
  }
}
