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
                          text: 'Crie sua nova senha!\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 4)),
                      TextSpan(
                          text: 'Digite sua nova senha, e confirme.',
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nova senha',
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
                        decoration: InputDecoration(
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
                //
                //ESPAÇAMENTO
                SizedBox(height: 40),
                //
                //
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 97, 62, 1),
                        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                        minimumSize: Size(367, 49),
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
