import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class EditPswdPage extends StatefulWidget {
  const EditPswdPage({super.key});

  @override
  _EditPswdState createState() => _EditPswdState();
}

class _EditPswdState extends State<EditPswdPage> {
  ParseUser? currentUser;
  Future<void> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

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
                SizedBox(height: 60),
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
                              'Caso deseje alterar sua senha,\npressione o botão abaixo para receber\ninstruções em seu email.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black.withOpacity(0.5))),
                    ],
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
                      'Enviar instruções',
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
                Navigator.pop(context);
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
    final ParseResponse parseResponse =
        await currentUser!.requestPasswordReset();
    if (parseResponse.success) {
      showSuccess(
          "As intruções para alterar sua senha foram enviadas em seu e-mail!");
    } else {
      showError(parseResponse.error!.message);
    }
  }
}
