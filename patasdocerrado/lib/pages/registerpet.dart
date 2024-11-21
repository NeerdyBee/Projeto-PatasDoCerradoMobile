import 'package:flutter/material.dart';

void main() {
  runApp(PetRegistrationApp());
}

class PetRegistrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Registration',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastre um novo pet',
              style: TextStyle(
                color: Color(0xFFFF6F4A),
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.arrow_back, color: Color(0xFFFF6F4A)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PetNameInput(),
              SizedBox(height: 20),
              CitySelection(),
              SizedBox(height: 20),
              AgeInput(),
              SizedBox(height: 20),
              SpeciesSelection(),
              SizedBox(height: 20),
              GenderSelection(),
              SizedBox(height: 20),
              SizeSelection(),
              SizedBox(height: 40),
              Center(child: NextStepButton(onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }
}

class PetNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> styles = {
      'position': {
        'left': 28,
        'top': 184,
      },
      'dimensions': {
        'width': 112,
        'height': 24,
      },
      'text': {
        'content': 'Digite o nome',
        'font': 'Poppins',
        'weight': FontWeight.w400,
        'size': 16.0,
        'lineHeight': 24.0,
        'color': Color(0xFF7E8A8C),
      },
    };

    return Padding(
      padding: EdgeInsets.only(
        left: styles['position']['left'].toDouble(),
        top: styles['position']['top'].toDouble(),
      ),
      child: SizedBox(
        width: styles['dimensions']['width'].toDouble(),
        height: styles['dimensions']['height'].toDouble(),
        child: TextField(
          decoration: InputDecoration(
            hintText: styles['text']['content'],
            hintStyle: TextStyle(
              fontSize: styles['text']['size'],
              fontWeight: styles['text']['weight'],
              color: styles['text']['color'],
              height: styles['text']['lineHeight'] / styles['text']['size'],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          style: TextStyle(
            fontSize: styles['text']['size'],
            fontWeight: styles['text']['weight'],
            height: styles['text']['lineHeight'] / styles['text']['size'],
          ),
        ),
      ),
    );
  }
}

class CitySelection extends StatefulWidget {
  @override
  _CitySelectionState createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  String? selectedCity;
  final List<String> cities = [
    'Goiânia',
    'Anápolis',
    'Aparecida de Goiânia',
    'Rio Verde',
    'Águas Lindas de Goiás',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Escolha a cidade',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.5,
            color: Color(0xFFFF623E),
          ),
        ),
        SizedBox(height: 10),
        DropdownButton<String>(
          hint: Text('Selecione a cidade'),
          value: selectedCity,
          onChanged: (String? newValue) {
            setState(() {
              selectedCity = newValue;
            });
          },
          items: cities.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AgeInput extends StatefulWidget {
  @override
  _AgeInputState createState() => _AgeInputState();
}

class _AgeInputState extends State<AgeInput> {
  final TextEditingController _controller = TextEditingController();
  String _selectedUnit = 'Anos';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 151,
      height: 42,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Digite a idade',
                border: InputBorder.none,
              ),
            ),
          ),
          DropdownButton<String>(
            value: _selectedUnit,
            items: <String>['Anos', 'Meses']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedUnit = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}

class SpeciesSelection extends StatefulWidget {
  @override
  _SpeciesSelectionState createState() => _SpeciesSelectionState();
}

class _SpeciesSelectionState extends State<SpeciesSelection> {
  bool isCaoSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isCaoSelected = true;
            });
          },
          child: Container(
            width: 97,
            height: 34,
            decoration: BoxDecoration(
              color: isCaoSelected ? Colors.orange : Colors.grey,
              borderRadius: BorderRadius.circular(17),
            ),
            alignment: Alignment.center,
            child: Text(
              'Cão',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              isCaoSelected = false;
            });
          },
          child: Container(
            width: 97,
            height: 34,
            decoration: BoxDecoration(
              color: !isCaoSelected ? Colors.orange : Colors.grey,
              borderRadius: BorderRadius.circular(17),
            ),
            alignment: Alignment.center,
            child: Text(
              'Gato',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GenderSelection extends StatefulWidget {
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool isMachoSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton('Macho', isMachoSelected, () {
          setState(() {
            isMachoSelected = true;
          });
        }),
        SizedBox(width: 10),
        _buildToggleButton('Fêmea', !isMachoSelected, () {
          setState(() {
            isMachoSelected = false;
          });
        }),
      ],
    );
  }

  Widget _buildToggleButton(
      String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.orange : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
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
  String selectedSize = 'Pequeno';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton('Pequeno'),
        _buildToggleButton('Médio'),
        _buildToggleButton('Grande'),
      ],
    );
  }

  Widget _buildToggleButton(String size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedSize == size
                ? const Color.fromARGB(255, 255, 211, 146)
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: selectedSize == size ? Colors.orange : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class NextStepButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextStepButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFF6F4A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        'Próximo passo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
