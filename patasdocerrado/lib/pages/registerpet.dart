import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // Tela de fundo branca
        appBar: AppBar(
          title: Text(
            'Cadastre um novo pet',
            style: TextStyle(color: Colors.orange),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.orange),
              onPressed: () {
                // Adicionar ação de saída se necessário
              },
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
                PetNameInput(),
                SizedBox(height: 16),
                _buildTitle('Cidades do Goiás'),
                CitySelection(),
                SizedBox(height: 16),
                _buildTitle('Idade'),
                AgeInput(),
                SizedBox(height: 16),
                _buildTitle('Espécie'),
                SpeciesSelection(),
                SizedBox(height: 16),
                _buildTitle('Sexo'),
                GenderSelection(),
                SizedBox(height: 16),
                _buildTitle('Porte'),
                SizeSelection(),
                SizedBox(height: 32),
                SubmitButton(onPressed: () {}),
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
        fontSize: 16, // Diminui o tamanho da fonte
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }
}

// Campo de nome do pet
class PetNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Nome do Pet',
        labelStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}

// Campo de seleção de cidade
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
    return DropdownButtonFormField<String>(
      value: _selectedCity,
      decoration: InputDecoration(
        labelText: 'Escolha a cidade',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
    );
  }
}

// Campo de idade
class AgeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Digite a idade',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Color(0xFFFF623E),
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 8), // Cor laranja
          ),
          child: Text('Anos'),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Color(0xFFFF623E),
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 8), // Cor laranja
          ),
          child: Text('Meses'),
        ),
      ],
    );
  }
}

// Seleção de espécie
class SpeciesSelection extends StatefulWidget {
  @override
  _SpeciesSelectionState createState() => _SpeciesSelectionState();
}

class _SpeciesSelectionState extends State<SpeciesSelection> {
  bool isDogSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinhamento à esquerda
      children: <Widget>[
        _buildSpeciesButton('Cão', isDogSelected),
        SizedBox(width: 10),
        _buildSpeciesButton('Gato', !isDogSelected),
      ],
    );
  }

  Widget _buildSpeciesButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDogSelected = text == 'Cão';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFFFF623E)
              : Colors.white, // Alterado para branco quando não selecionado
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black, // Adiciona uma borda preta
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // Cor do texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Seleção de sexo
class GenderSelection extends StatefulWidget {
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool isMaleSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinhamento à esquerda
      children: <Widget>[
        _buildGenderButton('Macho', isMaleSelected),
        SizedBox(width: 10),
        _buildGenderButton('Fêmea', !isMaleSelected),
      ],
    );
  }

  Widget _buildGenderButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMaleSelected = text == 'Macho';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFFFF623E)
              : Colors.white, // Alterado para branco quando não selecionado
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black, // Adiciona uma borda preta
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // Cor do texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Seleção de porte
class SizeSelection extends StatefulWidget {
  @override
  _SizeSelectionState createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {
  String _selectedSize = 'Pequeno';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinhamento à esquerda
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
    return ChoiceChip(
      label: Text(size),
      selected: _selectedSize == size,
      onSelected: (selected) {
        setState(() {
          _selectedSize = size;
        });
      },
      selectedColor: Color(0xFFFF623E), // Cor laranja
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

// Botão de cadastro
class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF623E), // Cor laranja
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: 156, vertical: 20), // Aumentar o tamanho do botão
        ),
        child: Text(
          'Concluir Cadastro',
          style: TextStyle(
              color: Colors.white, fontSize: 18), // Ajustar tamanho da fonte
        ),
      ),
    );
  }
}
