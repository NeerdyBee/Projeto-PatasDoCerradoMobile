import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover o banner de DEBUG
      home: Scaffold(
        backgroundColor: Colors.white,
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
                onPressed: () {},
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
                  width: 350, // Largura ajustada
                  child: PetNameInput(),
                ),
                SizedBox(height: 20),
                _buildTitle('Cidades do Goiás'),
                SizedBox(height: 10),
                // LARGURA: Ajustado para 250 pixels
                Container(
                  width: 350, // Largura ajustada
                  child: CitySelection(),
                ),
                SizedBox(height: 20),
                _buildTitle('Idade'),
                SizedBox(height: 10),
                // LARGURA: Ajustado para 250 pixels
                Container(
                  width: 350, // Largura ajustada
                  child: AgeInput(),
                ),
                SizedBox(height: 20),
                _buildTitle('Espécie'),
                SizedBox(height: 10),
                SpeciesSelection(),
                SizedBox(height: 20),
                _buildTitle('Sexo'),
                SizedBox(height: 10),
                GenderSelection(),
                SizedBox(height: 20),
                _buildTitle('Porte'),
                SizedBox(height: 10),
                SizeSelection(),
                SizedBox(height: 50),
                SubmitButton(onPressed: () {
                  print('Cadastro concluído!');
                }),
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
}

class PetNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Digite o nome',
            hintStyle: TextStyle(color: Colors.grey), // Cor cinza
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ));
  }
}

class CitySelection extends StatefulWidget {
  @override
  _CitySelectionState createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  String? _selectedCity;
  final List<String> _cities = [
    'Goiânia',
    'Anápolis',
    'Aparecida de Goiânia',
    'Rio Verde',
    'Luziânia',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: DropdownButtonFormField<String>(
          value: _selectedCity,
          decoration: InputDecoration(
            hintText: 'Escolha a cidade',
            hintStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 98, 62)), // Cor laranja
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16), // Largura da borda
          ),
          items: _cities.map((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedCity = newValue;
            });
          },
        ));
  }
}

class AgeInput extends StatefulWidget {
  @override
  _AgeInputState createState() => _AgeInputState();
}

class _AgeInputState extends State<AgeInput> {
  String _selectedAgeType = 'Anos';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            width: 250, // Largura ajustada para o campo de Idade
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Digite a idade',
                hintStyle: TextStyle(color: Colors.grey), // Cor cinza
                border: InputBorder.none,

                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        _buildAgeButton('Anos'),
        SizedBox(width: 8),
        _buildAgeButton('Meses'),
      ],
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
}

class SpeciesSelection extends StatefulWidget {
  @override
  _SpeciesSelectionState createState() => _SpeciesSelectionState();
}

class _SpeciesSelectionState extends State<SpeciesSelection> {
  String _selectedSpecies = 'Cão';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildSpeciesButton('Cão'),
        SizedBox(width: 10),
        _buildSpeciesButton('Gato'),
      ],
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
}

class GenderSelection extends StatefulWidget {
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String _selectedGender = 'Macho';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildGenderButton('Macho'),
        SizedBox(width: 10),
        _buildGenderButton('Fêmea'),
      ],
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
}

class SizeSelection extends StatefulWidget {
  @override
  _SizeSelectionState createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {
  String _selectedSize = 'Pequeno';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildSizeButton('Pequeno'),
        SizedBox(width: 10),
        _buildSizeButton('Médio'),
        SizedBox(width: 10),
        _buildSizeButton('Grande'),
      ],
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
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF623E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 169, vertical: 20),
        ),
        child: Text(
          'Próximo passo',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
