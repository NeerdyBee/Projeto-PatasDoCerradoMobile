import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:patasdocerrado/pages/register_pet_next.dart';

class RegisterPetPage extends StatefulWidget {
  const RegisterPetPage({super.key});

  @override
  _RegisterPetPageState createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {
  String _selectedAgeType = 'Anos';
  String _selectedSpecies = 'Cão';
  String _selectedGender = 'Macho';
  String _selectedSize = 'Pequeno';
  final controllerPetName = TextEditingController();
  final controllerIdade = TextEditingController();
  String? _selectedCity;
  List<dynamic> listCidades = [];
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
              doRegisterPetNext();
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
              'Próximo passo',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            'Cadastre um novo pet',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle('Nome do Pet'),
                SizedBox(height: 10),
                // LARGURA: Ajustado para 250 pixels
                Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.5),
                    ),
                    child: TextField(
                      controller: controllerPetName,
                      decoration: InputDecoration(
                        hintText: 'Digite o nome',
                        hintStyle: TextStyle(color: Colors.grey), // Cor cinza
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    )),
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
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.5),
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
                        hintStyle: TextStyle(color: Colors.grey), // Cor cinza
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

  void doRegisterPetNext() {
    final nome = controllerPetName.text;
    final cidade = _selectedCity;
    final idade = controllerIdade.text;
    final tipoIdade = _selectedAgeType;
    final especie = _selectedSpecies;
    final genero = _selectedGender;
    final porte = _selectedSize;
    if (nome == "" || cidade == null || idade == "") {
      showError("Certifique-se de inserir todas as informações do animal!");
      return;
    }
    List<dynamic> dados = [
      nome,
      cidade,
      tipoIdade,
      especie,
      genero,
      porte,
      idade
    ];
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterPetPage2(dados)));
  }
}

class CommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String _text = newValue.text;
    //This is only if you need signed numbers. Will convert the first '.'(dot) to '-'(minus)
    //if (_text.isNotEmpty && _text[0] == '.')
    //  _text = _text.replaceFirst('.', '-');
    return newValue.copyWith(
      text: _text.replaceAll('.', ','),
    );
  }
}
