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
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
          title: Text('Cadastro'),
          centerTitle: true,
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Digite seu nome de usuário',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xff8d8d8d))),
                    ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Selecione sua cidade',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xff8d8d8d))),
                    ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Digite seu CPF',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xff8d8d8d))),
                    ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Digite seu e-mail',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xff8d8d8d))),
                    ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Digite seu telefone',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xff8d8d8d))),
                    ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: Color(0xffFF623E),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: Color(0xffFF623E),
                              _confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          hintText: 'Confirmar senha',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xff8d8d8d))),
                    ),
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
