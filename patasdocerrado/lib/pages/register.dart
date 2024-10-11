// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

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
            onPressed: () => Navigator.pushNamed(context, '/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(255, 97, 62, 1),
              foregroundColor: Color.fromRGBO(255, 255, 255, 1),
              minimumSize: Size(367, 49),
              maximumSize: Size(367, 49),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Cadastrar',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        // APP BAR
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_rounded),
          title: Text('Cadastro'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        // SCROLLABLE BODY
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffE6E6E6),
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Color(0xffCCCCCC),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                        radius: 16,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: 'Insira uma foto de perfil\n',
                  style: TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ),
              // Remaining code unchanged
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Nome de Usuário',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Digite seu nome de usuário',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Cidade',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Sua Cidade',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Nome',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Digite seu nome',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'CPF',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Digite seu CPF',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'E-mail',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Digite seu e-mail',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Telefone',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Digite seu telefone',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Senha',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Senha',
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Confirmar senha',
                          style: TextStyle(
                            fontSize: 16,
                            height: 2,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: TextField(
                  obscureText: !_confirmPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 221, 221, 221),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Confirmar senha',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
