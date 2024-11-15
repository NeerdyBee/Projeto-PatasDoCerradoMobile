// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
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
            onPressed: () => Navigator.of(context).pop(),
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
              'Salvar informações',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        // APP BAR
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
          title: Text('Configurações de Perfil'),
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
                          Icons.edit,
                          size: 20,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ],
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                    hintText: 'Pedro Fran',
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                    hintText: 'Rialma',
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                    hintText: 'pedroF@email.com',
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                    hintText: '123.456.789-22',
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                    hintText: '1234-5678',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
