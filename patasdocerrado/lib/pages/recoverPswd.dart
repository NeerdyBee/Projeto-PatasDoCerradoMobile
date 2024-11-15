import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RecoverPswdPage extends StatefulWidget {
  const RecoverPswdPage({super.key});

  @override
  _RecoverPswdState createState() => _RecoverPswdState();
}

class _RecoverPswdState extends State<RecoverPswdPage> {
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop()),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
            ),
            body: Column(
              children: [
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/logo.png', height: 130)
                    ]),
                SizedBox(height: 40),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Esqueceu sua senha?\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 4)),
                      TextSpan(
                          text:
                              'Vamos ajuda-lo nisso! Digite o e-mail de\nsua conta para enviarmos as instruções.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 67),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.0),
                    ),
                    child: Expanded(
                      child: TextField(
                        controller: controllerEmail,
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
                SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () => doUserResetPassword(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: Size(367, 49),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Confirmar',
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            )));
  }

  void showSuccess(String message) {
    final content = message;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Arrasou!"),
          content: Text(content),
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

  void doUserResetPassword() async {
    final email = controllerEmail.text.trim();
    if (email.isEmpty) {
      showError("É necessário inserir um e-mail!");
      return;
    }
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (parseResponse.success) {
      showSuccess(
          "As intruções para resetar sua senha foram enviadas em seu e-mail!");
    } else {
      showError(parseResponse.error!.message);
    }
  }
}
