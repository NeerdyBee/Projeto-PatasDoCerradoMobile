import 'package:flutter/material.dart';
import 'package:patasdocerrado/components/my_petcard.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'logo.png',
                          width: 93,
                          height: 54,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSearchBar(),
                          SizedBox(width: 8),
                          _buildFilterButton(context),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16), // FADE DA PARTE DE CIMA
                Expanded(
                  child: Stack(
                    children: [
                      _buildPetList(),
                      _buildFadeOverlay(top: true),
                      _buildFadeOverlay(top: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    // BARRA DE PESQUISA INICAL
    return Container(
      width: 350,
      height: 40,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                border: InputBorder.none,
                hintText: 'Pesquisar',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    // BOTAO DO FILTRO
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFFFF623E),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.filter_list, color: Colors.white),
        onPressed: () => _showFilterModal(context), // CHAMA O MODEL FILTRO
      ),
    );
  }

  Widget _buildPetList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PetCard(imageName: 'dog0${index + 1}.jpg'),
        );
      },
    );
  }

  void _showFilterModal(BuildContext context) {
    // CONSTROI O MODAL DO FILTRO
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Color.fromARGB(255, 56, 56, 56)
          .withOpacity(0.95), // COR DO FUNDO DO FILTRO P TELA DE TRAS
      transitionAnimationController: AnimationController(
        // ANIMAÇÃO DE ENTRADA
        vsync: Navigator.of(context),
        duration: Duration(milliseconds: 600),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.92, //ALTURA DO FILTRO
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModalHeader(),
                SizedBox(height: 16),
                _buildFilterSection('Buscar pet por nome', Icons.search),
                SizedBox(height: 16),
                _buildFilterSection('Cidades do Goiás', null, showButton: true),
                SizedBox(height: 16),
                _buildFilterOptions('Espécie', ['Cão', 'Gato']),
                SizedBox(height: 16),
                _buildFilterOptions('Sexo', ['Macho', 'Femea']),
                SizedBox(height: 16),
                _buildFilterOptions('Porte', ['Pequeno', 'Médio', 'Grande']),
                SizedBox(height: 40),
                _buildShowResultsButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalHeader() {
    // TITULO DO MODAL FILTRO
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Preferencias de busca',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xffFF623E),
          ),
        ),
        Row(
          // RESETAR
          children: [
            Text(
              'Resetar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Color(0xff7e8a8c),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Color(0xff7e8a8c),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShowResultsButton() {
    // BOTÃO MOSTRAR RESULTADOS
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffFF623E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(450, 60),
        ),
        child: Text(
          'Mostrar resultados',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, IconData? icon, // TEXTOS TITULOS
      {bool showButton = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xff193238),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              if (icon != null) Icon(icon, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title == 'Buscar pet por nome'
                        ? 'Pesquisar'
                        : 'Todas as cidades',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: title == 'Cidades do Goiás'
                          ? Color(0xFFFF623E)
                          : Color(
                              0xff8d8d8d), // Update color for 'Todas as cidades'
                    ),
                  ),
                ),
              ),
              if (showButton)
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'GO',
                    style: TextStyle(color: Color(0xffFF623E)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOptions(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xff193238),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(
                  option,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color(0xff7e8a8c),
                  ),
                ),
                selected: false,
                onSelected: (selected) {},
                backgroundColor: Colors.white,
                selectedColor: Color(0xffFF623E),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFadeOverlay({required bool top}) {
    // FADE DA PARTE DE BAIXO
    return Positioned(
      top: top ? 0 : null,
      bottom: top ? null : 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Container(
          height: 15.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: top ? Alignment.topCenter : Alignment.bottomCenter,
              end: top ? Alignment.bottomCenter : Alignment.topCenter,
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
