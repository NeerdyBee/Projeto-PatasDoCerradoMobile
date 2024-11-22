// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  ParseUser? currentUser;
  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<ParseUser?>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );

                default:
                  int count = 0;
                  TextEditingController controllerUsername =
                      TextEditingController(
                          text: ('${snapshot.data!.username}'));
                  TextEditingController controllerCidade =
                      TextEditingController(
                          text: ('${snapshot.data!.get('usuario_cidade')}'));
                  TextEditingController controllerEmail = TextEditingController(
                      text: ('${snapshot.data!.emailAddress}'));
                  TextEditingController controllerCpf = TextEditingController(
                      text: ('${snapshot.data!.get('cpf')}'));
                  TextEditingController controllerTelefone =
                      TextEditingController(
                          text: ('${snapshot.data!.get('telefone')}'));
                  return Scaffold(
                    backgroundColor: Colors.white,
                    bottomNavigationBar: BottomAppBar(
                      color: Colors.transparent,
                      elevation: 0,
                      child: ElevatedButton(
                        onPressed: () => updateUser((snapshot.data!.objectId)),
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
                          icon: Icon(Icons.arrow_back_ios_rounded,
                              color: Colors.black),
                          onPressed: () => Navigator.of(context)
                              .popUntil((_) => count++ >= 2)),
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
                                    backgroundColor:
                                        Color.fromRGBO(255, 97, 62, 1),
                                    radius: 16,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Remaining code unchanged
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: TextField(
                              controller: controllerUsername,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: TextField(
                              controller: controllerCidade,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: TextField(
                              controller: controllerEmail,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: TextField(
                              controller: controllerCpf,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: TextField(
                              controller: controllerTelefone,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 221, 221, 221),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
              }
            }));
  }

  Future<void> updateUser(String id, String username, String cidade,
      String email, String cpf, String telefone) async {
    final todo = ParseObject('_User')
      ..objectId = id
      ..set('username', username)
      ..set('email', email)
      ..set('cpf', cpf)
      ..set('telefone', telefone);
    await todo.save();
  }
}
