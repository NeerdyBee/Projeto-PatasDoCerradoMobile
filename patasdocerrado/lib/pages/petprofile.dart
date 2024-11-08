import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // DESABILITA O BANNER DE DEBUG
      home: Scaffold(
        body:
            DogImageComponent(), // COMPONENTE PRINCIPAL COM IMAGEM E INFORMAÇÕES DO CÃO
      ),
    );
  }
}

class DogImageComponent extends StatefulWidget {
  @override
  _DogImageComponentState createState() => _DogImageComponentState();
}

class _DogImageComponentState extends State<DogImageComponent>
    with TickerProviderStateMixin {
  late AnimationController _controller; // CONTROLADOR DA ANIMAÇÃO
  bool _isBoxVisible =
      false; // FLAG PARA CONTROLAR A VISIBILIDADE DA CAIXA ANIMADA

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300), // DURAÇÃO DA ANIMAÇÃO
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // DESCARTAR O CONTROLADOR QUANDO NÃO FOR MAIS NECESSÁRIO
    super.dispose();
  }

  // FUNÇÃO PARA TOGLAR A VISIBILIDADE DA CAIXA ANIMADA
  void _toggleBox() {
    setState(() {
      if (_isBoxVisible) {
        _controller.reverse(); // FAZ A CAIXA DESCER
      } else {
        _controller.forward(); // FAZ A CAIXA SUBIR
      }
      _isBoxVisible = !_isBoxVisible; // TOGGLE DO ESTADO DA CAIXA
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // IMAGEM DE FUNDO DO CÃO
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            '..//assets/dog01.jpg', // CAMINHO DA IMAGEM
            width: MediaQuery.of(context).size.width,
            height: 460,
            fit: BoxFit.cover, // GARANTE QUE A IMAGEM FIQUE BEM AJUSTADA
          ),
        ),

        // ÍCONE DE SAÍDA (VOLTAR PARA A TELA ANTERIOR)
        Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(); // VAI VOLTAR PARA A TELA ANTERIOR
            },
          ),
        ),

        // CONTAINER PRINCIPAL COM O COMPONENTE DE ADOÇÃO DO CÃO
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.57,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: DogAdoptionComponent(
                onAdoptClicked: _toggleBox), // CHAMA O COMPONENTE DE ADOÇÃO
          ),
        ),

        // CAIXA ANIMADA DE INFORMAÇÕES SOBRE O CÃO E O BOTÃO DE ADOÇÃO
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut, // CURVA SUAVE PARA A ANIMAÇÃO
          bottom:
              _isBoxVisible ? 0 : -570, // A CAIXA FICA VISÍVEL OU DESAPARECE
          left: 0,
          right: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 570, // ALTURA DA CAIXA
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ROW PARA ALINHAR O TÍTULO E A SETA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TÍTULO DA CAIXA
                      RichText(
                        text: TextSpan(
                          text: 'Gostou do Bartho?', // PERGUNTA SOBRE O CÃO
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFFFF5239),
                          ),
                        ),
                      ),
                      // ÍCONE DE SETA PARA FECHAR A CAIXA ANIMADA
                      GestureDetector(
                        onTap:
                            _toggleBox, // Chama a função para alternar a visibilidade
                        child: Icon(
                          _isBoxVisible
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Color(0xFFFF5239),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // TEXTO INFORMATIVO SOBRE ADOÇÃO
                  Text(
                    'Para adotar esse pet ou saber mais sobre ele, entre em contato com o protetor;',
                    style: TextStyle(
                      fontFamily: 'Rialma',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0x8A808080),
                    ),
                  ),
                  SizedBox(height: 40),

                  // INFORMAÇÕES SOBRE O DONO DO CÃO
                  Center(
                    child: Container(
                      width: 400,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color(0x0FFFFF5ED),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/person.jpg'), // FOTO DO DONO
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              Text(
                                'Jessica Martins', // NOME DO DONO
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Color(0xFFFF5239),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Rialma, Goias', // LOCALIZAÇÃO DO DONO
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0x8A808080),
                                ),
                              ),
                              SizedBox(height: 35),
                              // TELEFONE DO DONO
                              Row(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    color: Color(0xFFFF5239),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '(62) 98572-0028',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // E-MAIL DO DONO
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Color(0xFFFF5239),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'jessicamartins01@gmail.com',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DogAdoptionComponent extends StatelessWidget {
  final VoidCallback onAdoptClicked;

  DogAdoptionComponent({required this.onAdoptClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // NOME DO CÃO
          RichText(
            text: TextSpan(
              text: 'Bartho', // NOME DO CÃO
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFFFF5239),
              ),
            ),
          ),
          SizedBox(height: 5),
          // LOCALIZAÇÃO DO CÃO
          Text(
            'Rialma, Goias', // LOCALIZAÇÃO
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0x8A808080),
            ),
          ),
          SizedBox(height: 20),
          // INFORMAÇÕES PRINCIPAIS DO CÃO
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(title: 'Idade', info: '2 Anos'),
              SizedBox(width: 40),
              InfoCard(title: 'Sexo', info: 'Macho'),
              SizedBox(width: 40),
              InfoCard(title: 'Porte', info: 'Médio'),
            ],
          ),
          SizedBox(height: 20),
          // BOTÃO PARA CONHECER A HISTÓRIA DO CÃO
          Text(
            'Conheça minha história',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFFFF5239),
            ),
          ),
          SizedBox(height: 10),
          DogDetailsComponent(),
          SizedBox(height: 20),
          OwnerCard(name: 'Jessica Martins', location: 'Rialma, Goias'),
          SizedBox(height: 20),
          Center(
            // BOTÃO PARA ADOTAR O CÃO
            child: GestureDetector(
              onTap: onAdoptClicked,
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Quero adotar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFF5239),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Ver informações para adoção',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0x8A808080),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String info;

  InfoCard({required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0x0FFFFF5ED),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // TÍTULO DA INFORMAÇÃO (Ex: Idade, Sexo)
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xFFFF5239),
              ),
            ),
          ),
          // DADO DA INFORMAÇÃO (Ex: 2 Anos, Macho)
          Text(
            info,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF7E8A8C),
            ),
          ),
        ],
      ),
    );
  }
}

class OwnerCard extends StatelessWidget {
  final String name;
  final String location;

  OwnerCard({required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0x0FFFFF5ED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // AVATAR DO DONO
          CircleAvatar(
            radius: 23,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NOME DO DONO
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFFFF5239),
                ),
              ),
              // LOCALIZAÇÃO DO DONO
              Text(
                location,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0x8A808080),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DogDetailsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Text(
        'Bartho é um adorável vira-lata que passou seus primeiros anos vivendo nas ruas. Ele é um verdadeiro sobrevivente, sempre com um brilho nos olhos e uma esperança no coração. Um dia, enquanto vagava em busca de comida, Bartho foi resgatado por uma equipe de voluntários que se apaixonaram instantaneamente por sua energia contagiante e seu espírito amigável.',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 11,
          height: 24 / 11,
          color: Color(0xFF7e8a8c),
        ),
      ),
    );
  }
}
