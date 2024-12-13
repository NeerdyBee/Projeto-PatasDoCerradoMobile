import 'package:flutter/material.dart';

void main() => runApp(PetRegistrationScreen());

class PetRegistrationScreen extends StatefulWidget {
  @override
  _PetRegistrationScreenState createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  List<String> images = [];

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
                onPressed: () {},
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
                  'Adicione até 03 imagens',
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
                    _buildAnimatedImageUploadBox(),
                    SizedBox(width: 16),
                    _buildAnimatedImageUploadBox(),
                    SizedBox(width: 16),
                    _buildAnimatedImageUploadBox(),
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
                      hintText: 'Conte um pouco de sua história...',
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
                    onPressed: () {},
                    child: Text(
                      'Concluir Cadastro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF623E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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

  // Função para criar um box com animação
  Widget _buildAnimatedImageUploadBox() {
    return AnimatedImageUploadButton();
  }
}

// Classe do botão com animação
class AnimatedImageUploadButton extends StatefulWidget {
  @override
  _AnimatedImageUploadButtonState createState() =>
      _AnimatedImageUploadButtonState();
}

class _AnimatedImageUploadButtonState extends State<AnimatedImageUploadButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
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
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 77,
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: const Color(0xFFFF623E),
              size: 45,
            ),
          ),
        ),
      ),
    );
  }
}
