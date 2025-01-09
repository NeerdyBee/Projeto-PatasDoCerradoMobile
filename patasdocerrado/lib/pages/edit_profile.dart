import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  String? _selectedCity;
  List<dynamic> listCidades = [];
  dynamic currentUser = "";
  String nome = "";
  String email = "";
  String telefone = "";
  String cidade = "";
  String foto = "";

  final ImagePicker picker = ImagePicker();
  XFile? controllerImg;
  File? controllerImgPath;

  Future pickImage() async {
    try {
      controllerImg = await picker.pickImage(source: ImageSource.gallery);
      if (controllerImg != null) {
        controllerImgPath = File(controllerImg!.path);
        setState(() {
          debugPrint('$controllerImgPath');
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<ParseUser?> getUser() async {
    ParseUser? u = await ParseUser.currentUser() as ParseUser?;
    final QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo('dono_usuario', u);
    ParseResponse responseDono = await donoQuery.query();
    final QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo("objectId",
              responseDono.results!.first.get('dono_cidade').get('objectId'));
    ParseResponse responseCidade = await cidadeQuery.query();
    setState(() {
      nome = responseDono.results!.first.get('nome');
      print("Dono $nome");
    });
    setState(() {
      email = responseDono.results!.first.get('email');
    });
    setState(() {
      telefone = responseDono.results!.first.get('telefone');
    });
    setState(() {
      cidade = responseCidade.results!.first.get("nome");
    });
    setState(() {
      foto = responseDono.results!.first.get("foto").get("url");
    });
    setState(() {
      _selectedCity = cidade;
    });
    setState(() {
      currentUser = u;
    });
    return currentUser;
  }

  Future<void> readJsonFile() async {
    String input =
        await DefaultAssetBundle.of(context).loadString("assets/Cidade.json");
    var map = jsonDecode(input);
    setState(() {
      listCidades.clear();
      listCidades.add(map['results']);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJsonFile();
      await getUser();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUsername =
        TextEditingController(text: (nome));
    TextEditingController controllerEmail =
        TextEditingController(text: (email));
    TextEditingController controllerCpf = TextEditingController(
        text: currentUser is ParseUser ? (currentUser!.get('cpf')) : "");
    TextEditingController controllerTelefone =
        TextEditingController(text: (telefone));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            // APP BAR
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Configurações de Perfil'),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
            ),
            // SCROLLABLE BODY
            body: currentUser != ""
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                pickImage();
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: controllerImgPath == null
                                      ? NetworkImage(foto)
                                      : FileImage(controllerImgPath!),
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
                            )),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                        listCidades.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 2.0),
                                  ),
                                  child: Expanded(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child:
                                              DropdownButtonFormField<dynamic>(
                                            menuMaxHeight: 300,
                                            elevation: 1000,
                                            dropdownColor: Color.fromARGB(
                                                255, 243, 241, 241),
                                            value: _selectedCity,
                                            hint: Text('Selecione sua cidade'),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedCity =
                                                    newValue as String;
                                              });
                                            },
                                            items: listCidades[0]
                                                .map<DropdownMenuItem<dynamic>>(
                                                    (dynamic value) {
                                              return DropdownMenuItem<dynamic>(
                                                value: value['nome'],
                                                child: Text(value['nome']),
                                              );
                                            }).toList(),
                                          ))),
                                ),
                              )
                            : SizedBox(),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                        ),

                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () => updateUser(
                            currentUser!.objectId,
                            controllerUsername.text,
                            _selectedCity!,
                            controllerEmail.text,
                            controllerCpf.text,
                            controllerTelefone.text,
                          ),
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
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF623E),
                        )),
                  )));
  }

  dynamic getImage() {
    ParseFile parseI;
    if (controllerImgPath == null) {
      return null;
    } else {
      parseI = ParseFile(File(controllerImgPath!.path));
      parseI.name = "${nome}_profile_picture";
      return parseI;
    }
  }

  Future<void> updateUser(
      String? userId,
      String controllerUsername,
      String controllerCidade,
      String controllerEmail,
      String controllerCpf,
      String controllerTelefone) async {
    final _username = controllerUsername.trim();
    final _cidade = controllerCidade.trim();
    final _email = controllerEmail.trim();
    final _cpf = controllerCpf.trim();
    final _telefone = controllerTelefone.trim();
    ParseFileBase? _parseImage = getImage();
    if (_username.isEmpty ||
        _email.isEmpty ||
        _cpf.isEmpty ||
        _telefone.isEmpty) {
      showError("Tenha certeza de preencher todos os campos!");
      return;
    }

    QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo("dono_usuario", currentUser);
    ParseResponse donoResponse = await donoQuery.query();
    final _donoId = donoResponse.results?.first.objectId;

    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo("nome", _cidade);
    ParseResponse cidadeResponse = await cidadeQuery.query();
    final _cidadeObj = cidadeResponse.results?.first;

    final user = ParseObject("_User")
      ..objectId = userId
      ..set("username", _email)
      ..set("email", _email)
      ..set("cpf", _cpf);
    print("Usuario: $user");
    final ParseResponse responseUser = await user.save();

    if (responseUser.success) {
      ParseObject dono = ParseObject("Dono")
        ..objectId = _donoId
        ..set("nome", _username)
        ..set("telefone", _telefone)
        ..set("email", _email)
        ..set("dono_cidade", _cidadeObj);
      if (_parseImage != null) {
        dono.set("foto", _parseImage);
      }
      print("Dono: $dono");
      final ParseResponse responseDono = await dono.save();
      if (responseDono.success) {
        showSuccess();
      } else {
        showError(responseDono.error!.message);
      }
    } else {
      showError(responseUser.error!.message);
    }
  }

  void showSuccess() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Concluído!"),
          content: const Text("Seus dados foram atualizados com sucesso!"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pushNamed(context, "/homepage");
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
}
