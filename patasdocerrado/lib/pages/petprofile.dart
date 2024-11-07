import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        '../assets/dog01.jpg',
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0, // Ajuste de altura como desejado
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 520.0, // Increase this value as needed for overlap
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        PetAttributes(attribute: 'Idade', value: '2 Anos'),
                        PetAttributes(attribute: 'Sexo', value: 'Macho'),
                        PetAttributes(attribute: 'Porte', value: 'Médio'),
                      ],
                    ),
                    SizedBox(height: 16),
                    PetStory(),
                    SizedBox(height: 16),
                    OwnerInfo(),
                    SizedBox(height: 32),
                    ActionButton(
                      onPressed: () {
                        // Ação
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetAttributes extends StatelessWidget {
  final String attribute;
  final String value;

  PetAttributes({required this.attribute, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 79.0,
      height: 55.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF5F2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            attribute,
            style: TextStyle(
              color: Color(0xFFFF6347),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class PetStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://placeholder.pics/svg/344x168',
            width: 344,
            height: 168,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Text(
            'Conheça minha história',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Color(0xFFFF6347), // Orange color
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Bartho é um adorável vira-lata que passou seus primeiros anos vivendo nas ruas. Ele é um verdadeiro sobrevivente, sempre com um brilho nos olhos e uma esperança no coração. Um dia, enquanto vagava em busca de comida, Bartho foi resgatado por uma equipe de voluntários que se apaixonaram instantaneamente por sua energia contagiante e seu espírito amigável.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 11.0,
              color: Color(0xFF7E8A8C),
              height: 24.0 / 11.0,
            ),
          ),
        ],
      ),
    );
  }
}

class OwnerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354.0,
      height: 49.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF5ED),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://placeholder.pics/svg/40x40'),
            radius: 20.0,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Jessica Martins',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  height: 24.0 / 13.0,
                  color: Color(0xFFFF623E),
                ),
              ),
              Text(
                'Rialma, Goiás',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 354.0,
            height: 49.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
              onPressed: onPressed,
              child: const Text('Quero adotar',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Ver informações para adoção',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
