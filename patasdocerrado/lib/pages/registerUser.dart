import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final controllerUsername = TextEditingController();
  final controllerCidade = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();
  final controllerTelefone = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerCpf = TextEditingController();

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
            onPressed: () => doUserRegistration(),
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
                    color: Color(0xffFF623E),
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                      controller: controllerUsername,
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                      controller: controllerCidade,
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: controllerEmail,
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: controllerCpf,
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2.0),
                  ),
                  child: Expanded(
                    child: TextField(
                      controller: controllerTelefone,
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                      controller: controllerPassword,
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xff193238),
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
                      controller: controllerPasswordConfirm,
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

  void showSuccess() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Arrasou!"),
          content: const Text("Seu usuário foi criado com sucesso!"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro!"),
            content: Text(errorMessage),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final cidade = controllerCidade.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    final passwordConfirm = controllerPasswordConfirm.text.trim();
    final cpf = controllerCpf.text.trim();
    final telefone = controllerTelefone.text.trim();
    ParseObject cidadeObjt = new ParseObject("Cidade");
    Future<bool> doQueryCheck() async {
      final QueryBuilder<ParseObject> cidadeQuery =
          QueryBuilder<ParseObject>(ParseObject('Cidade'))
            ..whereEqualTo("nome", cidade);
      final ParseResponse queryResponse = await cidadeQuery.query();
      return (queryResponse.results == null);
    }

    void doQuerySet() async {
      final QueryBuilder<ParseObject> cidadeQuery =
          QueryBuilder<ParseObject>(ParseObject('Cidade'))
            ..whereEqualTo("nome", cidade);
      final ParseResponse queryResponse = await cidadeQuery.query();
      cidadeObjt = queryResponse.results?.first as ParseObject;
    }

    if (username.isEmpty ||
        cidade.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        passwordConfirm.isEmpty ||
        cpf.isEmpty ||
        telefone.isEmpty) {
      showError("Tenha certeza de preencher todos os campos!");
      return;
    }
    if (await doQueryCheck()) {
      showError("Cidade inserida não é uma cidade de Goiás!");
      return;
    } else {
      doQuerySet();
    }
    if (password != passwordConfirm) {
      showError("Tenha certeza de confirmar sua senha corretamente!");
      return;
    }

    if (password.length <= 3) {
      showError(
          "Senha muito curta. Insira uma senha com mais de 3 caractéres.");
      return;
    }

    final user = ParseObject("_User")
      ..set("username", username)
      ..set("email", email)
      ..set("password", password)
      ..set("cpf", cpf)
      ..set("telefone", telefone)
      ..set("animal_usuario", cidadeObjt.objectId);

    final ParseResponse response = await user.save();

    if (response.success) {
      showSuccess();
    } else {
      showError(response.error!.message);
    }
  }
}