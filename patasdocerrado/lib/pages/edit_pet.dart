import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/register_pet_next.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class EditPetPage extends StatefulWidget {
  ParseObject? pet;
  EditPetPage(ParseObject? p, {super.key}) {
    pet = p;
  }

  @override
  _EditPetPageState createState() => _EditPetPageState(pet);
}

class _EditPetPageState extends State<EditPetPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? controllerImg;
  File? controllerImgPath;
  bool _isPressed = false;
  ParseUser? currentUser;
  String _selectedAgeType = 'Anos';
  String _selectedSpecies = 'Cão';
  String _selectedGender = 'Macho';
  String _selectedSize = 'Pequeno';
  final controllerPetName = TextEditingController();
  final controllerIdade = TextEditingController();
  String? _selectedCity;
  List<dynamic> listCidades = [];
  ParseObject? pet;

  _EditPetPageState(ParseObject? p) {
    pet = p;
  }

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  Future<void> getInfo() async {
    controllerPetName.text = widget.pet!.get("nome");
    _descriptionController.text = widget.pet!.get("descricao");

    QueryBuilder<ParseObject> cidadeQuery = QueryBuilder(ParseObject('Cidade'))
      ..whereEqualTo(
          'objectId', widget.pet!.get('animal_cidade').get('objectId'));
    final ParseResponse cidadeResponse = await cidadeQuery.query();
    _selectedCity = cidadeResponse.results!.first.get('nome');

    controllerIdade.text = (widget.pet!.get('idade').toString());

    QueryBuilder<ParseObject> tipoIdadeQuery =
        QueryBuilder(ParseObject('TipoIdade'))
          ..whereEqualTo(
              'objectId', widget.pet!.get('animal_tipoIdade').get('objectId'));
    final ParseResponse tipoIdadeResponse = await tipoIdadeQuery.query();
    _selectedAgeType = tipoIdadeResponse.results!.first.get('nome');

    QueryBuilder<ParseObject> especieQuery =
        QueryBuilder(ParseObject('Especie'))
          ..whereEqualTo(
              'objectId', widget.pet!.get('animal_especie').get('objectId'));
    final ParseResponse especieResponse = await especieQuery.query();
    _selectedSpecies = especieResponse.results!.first.get('nome');

    QueryBuilder<ParseObject> generoQuery = QueryBuilder(ParseObject('Genero'))
      ..whereEqualTo(
          'objectId', widget.pet!.get('animal_genero').get('objectId'));
    final ParseResponse generoResponse = await generoQuery.query();
    _selectedGender = generoResponse.results!.first.get('nome');

    QueryBuilder<ParseObject> porteQuery = QueryBuilder(ParseObject('Porte'))
      ..whereEqualTo(
          'objectId', widget.pet!.get('animal_porte').get('objectId'));
    final ParseResponse porteResponse = await porteQuery.query();
    _selectedSize = porteResponse.results!.first.get('nome');
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
      await getInfo();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover o banner de DEBUG
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: ElevatedButton(
            onPressed: () {
              doUpdatePet();
            },
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
              'Concluir',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            'Editar informações do pet',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 98, 62),
              fontSize: 18, // Diminui o tamanho da fonte
              fontWeight: FontWeight.bold, // Deixa a fonte mais grossa
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0), // Ajusta a posição do ícone
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
        body: _selectedCity != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Imagem do animal',
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
                                        color: Colors.grey.shade300,
                                        width: 1.5),
                                  ),
                                  child: controllerImgPath != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image(
                                              image:
                                                  FileImage(controllerImgPath!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image(
                                              image: NetworkImage(
                                                  widget.pet!.get('foto').url),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildTitle('Nome do Pet'),
                      SizedBox(height: 10),
                      // LARGURA: Ajustado para 250 pixels
                      Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.5),
                          ),
                          child: TextField(
                            controller: controllerPetName,
                            decoration: InputDecoration(
                              hintText: 'Digite o nome',
                              hintStyle:
                                  TextStyle(color: Colors.grey), // Cor cinza
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                          )),
                      SizedBox(height: 20),
                      Text(
                        'Descrição',
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
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.5),
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
                      SizedBox(height: 20),

                      _buildTitle('Cidades do Goiás'),
                      SizedBox(height: 10),
                      // LARGURA: Ajustado para 250 pixels

                      listCidades.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1.5),
                              ),
                              child: Expanded(
                                  child: Container(
                                      width: 325,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: DropdownButtonFormField<dynamic>(
                                        menuMaxHeight: 300,
                                        elevation: 10,
                                        dropdownColor:
                                            Color.fromARGB(255, 243, 241, 241),
                                        value: _selectedCity,
                                        hint: Text('Selecione sua cidade'),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedCity = newValue as String;
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
                            )
                          : SizedBox(),
                      SizedBox(height: 20),
                      _buildTitle('Idade'),
                      SizedBox(height: 10),
                      // LARGURA: Ajustado para 250 pixels
                      Row(children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.5),
                          ), // Largura ajustada para o campo de Idade
                          child: TextField(
                            inputFormatters: [
                              CommaFormatter(),
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  r'^[0-9]*',
                                ),
                              ),
                            ],
                            controller: controllerIdade,
                            decoration: InputDecoration(
                              hintText: 'Digite a idade',
                              hintStyle:
                                  TextStyle(color: Colors.grey), // Cor cinza
                              border: InputBorder.none,

                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        _buildAgeButton('Anos'),
                        SizedBox(width: 8),
                        _buildAgeButton('Meses'),
                      ]),
                      SizedBox(height: 20),
                      _buildTitle('Espécie'),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          _buildSpeciesButton('Cão'),
                          SizedBox(width: 10),
                          _buildSpeciesButton('Gato'),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildTitle('Sexo'),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          _buildGenderButton('Macho'),
                          SizedBox(width: 10),
                          _buildGenderButton('Fêmea'),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildTitle('Porte'),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          _buildSizeButton('Pequeno'),
                          SizedBox(width: 10),
                          _buildSizeButton('Médio'),
                          SizedBox(width: 10),
                          _buildSizeButton('Grande'),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF623E),
                    )),
              ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildAgeButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAgeType = label;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor:
            _selectedAgeType == label ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _selectedAgeType == label ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSpeciesButton(String species) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedSpecies = species;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor:
            _selectedSpecies == species ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        species,
        style: TextStyle(
          color: _selectedSpecies == species ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildGenderButton(String gender) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor:
            _selectedGender == gender ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        gender,
        style: TextStyle(
          color: _selectedGender == gender ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedSize = size;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor:
            _selectedSize == size ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: _selectedSize == size ? Colors.white : Colors.black,
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
          content: const Text(
              "As informações do seu animal foram editados com sucesso!"),
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

  dynamic getImage() {
    ParseFile parseI;
    if (controllerImgPath == null) {
      return null;
    } else {
      parseI = ParseFile(File(controllerImgPath!.path));
      parseI.name = "${controllerPetName}_profile_picture";
      return parseI;
    }
  }

  void doUpdatePet() async {
    final nome = controllerPetName.text;
    final cidade = _selectedCity;
    final tipoIdade = _selectedAgeType;
    final especie = _selectedSpecies;
    final genero = _selectedGender;
    final porte = _selectedSize;
    final idade = int.parse(controllerIdade.text);
    ParseObject? donoObj;
    ParseObject? cidadeObj;
    ParseObject? tipoIdadeObj;
    ParseObject? especieObj;
    ParseObject? generoObj;
    ParseObject? porteObj;
    final descricao = _descriptionController.text.trim();
    ParseFileBase? parseImage = getImage();
    if (descricao == "") {
      showError("Certifique-se de inserir uma descrição para seu animal!");
      return;
    }

    if (nome == "") {
      showError("Certifique-se de inserir o nome do seu animal!");
      return;
    }

    if (controllerIdade.text == "") {
      showError("Certifique-se de inserir a idade do seu animal!");
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
    print("Usuario: $currentUser");
    print("Dono: $donoObj");
    final animal = ParseObject("Animal")
      ..objectId = widget.pet!.objectId
      ..set("nome", nome)
      ..set("descricao", descricao)
      ..set("idade", idade)
      ..set("animal_cidade", cidadeObj)
      ..set("animal_especie", especieObj)
      ..set("animal_porte", porteObj)
      ..set("animal_tipoIdade", tipoIdadeObj)
      ..set("animal_genero", generoObj)
      ..set("animal_dono", donoObj);
    if (parseImage != null) {
      animal.set("foto", parseImage);
    }
    final ParseResponse animalResponse = await animal.save();
    if (animalResponse.success) {
      showSuccess();
    } else {
      showError(animalResponse.error!.message);
    }
  }
}

class CommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String _text = newValue.text;
    return newValue.copyWith(
      text: _text.replaceAll('.', ','),
    );
  }
}
