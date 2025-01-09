import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RegisterPetPage2 extends StatefulWidget {
  List<dynamic>? listaDados;
  RegisterPetPage2(List<dynamic> dados, {super.key}) {
    listaDados = dados;
  }

  @override
  _RegisterPetPage2State createState() => _RegisterPetPage2State(listaDados);
}

class _RegisterPetPage2State extends State<RegisterPetPage2> {
  List<dynamic>? listaDados;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? controllerImg;
  File? controllerImgPath;
  bool _isPressed = false;
  ParseUser? currentUser;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  _RegisterPetPage2State(List<dynamic>? dados) {
    listaDados = dados;
    getUser();
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            'Cadastre um novo pet',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 98, 62),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    color: const Color.fromARGB(255, 255, 98, 62)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adicione uma imagem para seu pet',
                  style: TextStyle(
                    color: Color(0xFF193238),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isPressed = false;
                          pickImage();
                        });
                        print("Abrindo opção de adicionar imagem...");
                      },
                      onTapCancel: () {
                        setState(() {
                          _isPressed = false;
                        });
                      },
                      child: AnimatedScale(
                        scale: _isPressed ? 0.8 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          width: 210,
                          height: 210,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.5),
                          ),
                          child: controllerImgPath != null
                              ? Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                      image: FileImage(controllerImgPath!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.add,
                                    color: const Color(0xFFFF623E),
                                    size: 45,
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Adicione uma descrição',
                  style: TextStyle(
                    color: Color(0xFF193238),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 8,
                    maxLength: 400,
                    decoration: InputDecoration(
                      hintText:
                          'Conte um pouco sobre o pet e de sua história...',
                      hintStyle: TextStyle(
                        color: Color(0xFF93A1A4),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  '"Um ato de amor pode mudar o mundo de um animal. \n Poste, compartilhe e ajude a encontrar um lar cheio de carinho!"',
                  style: TextStyle(
                    color: Color(0xFF7E8A8C),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 70),
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: () => doRegisterPet(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF623E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Concluir Cadastro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  void showSuccess() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Arrasou!"),
          content: const Text("Seu animal foi criado com sucesso!"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/homepage');
              },
            ),
          ],
        );
      },
    );
  }

  void doRegisterPet() async {
    final nome = listaDados![0];
    final cidade = listaDados![1];
    final tipoIdade = listaDados![2];
    final especie = listaDados![3];
    final genero = listaDados![4];
    final porte = listaDados![5];
    final idade = int.parse(listaDados![6]);
    ParseObject? donoObj;
    ParseObject? cidadeObj;
    ParseObject? tipoIdadeObj;
    ParseObject? especieObj;
    ParseObject? generoObj;
    ParseObject? porteObj;
    ParseObject? statusAdocaoObj;

    final descricao = _descriptionController.text.trim();
    final img = controllerImgPath;
    ParseFileBase? parseImage;
    if (img != null) {
      parseImage = ParseFile(File(img.path));
      parseImage.name = "${nome}_pet_picture";
    } else {
      parseImage = null;
      showError("Tenha certeza de selecionar uma imagem para seu animal!");
      return;
    }
    if (descricao == "") {
      showError("Certifique-se de inserir uma descrição para seu animal!");
      return;
    }

    QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo("dono_usuario", currentUser);
    ParseResponse donoResponse = await donoQuery.query();
    donoObj = donoResponse.results?.first;

    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo("nome", cidade);
    ParseResponse cidadeResponse = await cidadeQuery.query();
    cidadeObj = cidadeResponse.results?.first;

    QueryBuilder<ParseObject> tipoIdadeQuery =
        QueryBuilder<ParseObject>(ParseObject('TipoIdade'))
          ..whereEqualTo("nome", tipoIdade);
    ParseResponse tipoIdadeResponse = await tipoIdadeQuery.query();
    tipoIdadeObj = tipoIdadeResponse.results?.first;

    QueryBuilder<ParseObject> especieQuery =
        QueryBuilder<ParseObject>(ParseObject('Especie'))
          ..whereEqualTo("nome", especie);
    ParseResponse especieResponse = await especieQuery.query();
    especieObj = especieResponse.results?.first;

    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereEqualTo("nome", genero);
    ParseResponse generoResponse = await generoQuery.query();
    generoObj = generoResponse.results?.first;

    QueryBuilder<ParseObject> porteQuery =
        QueryBuilder<ParseObject>(ParseObject('Porte'))
          ..whereEqualTo("nome", porte);
    ParseResponse porteResponse = await porteQuery.query();
    porteObj = porteResponse.results?.first;

    QueryBuilder<ParseObject> statusAdocaoQuery =
        QueryBuilder<ParseObject>(ParseObject('StatusAdocao'))
          ..whereEqualTo("nome", "Para adoção");
    ParseResponse statusAdocaoResponse = await statusAdocaoQuery.query();
    statusAdocaoObj = statusAdocaoResponse.results?.first;
    print("Usuario: $currentUser");
    print("Dono: $donoObj");
    final animal = ParseObject("Animal")
      ..set("nome", nome)
      ..set("foto", parseImage)
      ..set("descricao", descricao)
      ..set("idade", idade)
      ..set("animal_cidade", cidadeObj)
      ..set("animal_especie", especieObj)
      ..set("animal_porte", porteObj)
      ..set("animal_statusAdocao", statusAdocaoObj)
      ..set("animal_tipoIdade", tipoIdadeObj)
      ..set("animal_genero", generoObj)
      ..set("animal_dono", donoObj);
    final ParseResponse animalResponse = await animal.save();
    if (animalResponse.success) {
      showSuccess();
    } else {
      showError(animalResponse.error!.message);
    }
  }
}
