import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:patasdocerrado/components/my_petcard.dart';

class AdoptablesPage extends StatefulWidget {
  const AdoptablesPage({super.key});
  @override
  _AdoptablesPageState createState() => _AdoptablesPageState();
}

class _AdoptablesPageState extends State<AdoptablesPage> {
  List<ParseObject> results = <ParseObject>[];
  final controllerNome = TextEditingController();
  final controllerCidade = TextEditingController();
  String controllerEspecie = "";
  String controllerGenero = "";
  String controllerPorte = "";

  void doQueryMatches() async {
    final QueryBuilder<ParseObject> statusQuery =
        QueryBuilder<ParseObject>(ParseObject('StatusAdocao'))
          ..whereEqualTo("nome", "Para adoção");
    final QueryBuilder<ParseObject> petQuery =
        QueryBuilder<ParseObject>(ParseObject('Animal'))
          ..orderByDescending('createdAt')
          ..whereMatchesQuery("animal_statusAdocao", statusQuery);
    final ParseResponse queryResponse = await petQuery.query();
    if (!queryResponse.success) {
      setState(() {
        results.clear();
      });
    } else if (mounted) {
      setState(() {
        results = queryResponse.results as List<ParseObject>;
      });
    }
  }

  void doQuerySearch(QueryBuilder query) async {}

  void buildSearch() async {
    final nome = controllerNome.text.trim();
    final cidade = controllerCidade.text.trim();
    final especie = controllerEspecie.trim();
    final genero = controllerGenero.trim();
    final porte = controllerPorte.trim();
    List filtros = [nome, cidade, especie, genero, porte];
  }

  @override
  void initState() {
    super.initState();
    doQueryMatches();
  }

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
                          'assets/logo.png',
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
                          _buildFilter(context),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16), // FADE DA PARTE DE CIMA
                Expanded(
                  child: results.isNotEmpty
                      ? Stack(
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                final o = results[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: PetCard(pet: o, isFavoritos: false),
                                );
                              },
                            ),
                            _buildFadeOverlay(top: true),
                            _buildFadeOverlay(top: false),
                          ],
                        )
                      : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\n\n\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      height: 4)),
                              TextSpan(
                                  text:
                                      'Você ainda não tem nenhum pet para adoção.\n\nCaso deseje cadastrar um novo pet use o botão abaixo!',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black.withOpacity(0.5))),
                            ],
                          ),
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
              controller: controllerNome,
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

  Widget _buildFilter(BuildContext context) {
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

  void resetarAll() {
    controllerNome.text = "";
    controllerCidade.text = "";
    controllerEspecie = "";
    controllerPorte = "";
    controllerGenero = "";
  }

  void _showFilterModal(BuildContext context) {
    // CONSTROI O MODAL DO FILTRO
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Color.fromARGB(255, 56, 56, 56)
          .withOpacity(1), // COR DO FUNDO DO FILTRO P TELA DE TRAS
      transitionAnimationController: AnimationController(
        // ANIMAÇÃO DE ENTRADA
        vsync: Navigator.of(context),
        duration: Duration(milliseconds: 600),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.95, //ALTURA DO FILTRO
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModalHeader(),
                SizedBox(height: 16),
                _buildTitle("Buscar por nome"),
                _buildFilterSection('Buscar pet por nome', Icons.search),
                SizedBox(height: 16),
                _buildTitle("Cidade"),
                _buildFilterSection('Buscar cidade', Icons.search),
                SizedBox(height: 16),
                _buildTitle("Espécies"),
                EspecieOptions(),
                SizedBox(height: 16),
                _buildTitle("Gênero"),
                GeneroOptions(),
                SizedBox(height: 16),
                _buildTitle("Porte"),
                CidadeOptions(),
                SizedBox(height: 40),
                _buildShowResultsButton(),
              ],
            ),
          ),
        );
      },
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

  Widget _buildModalHeader() {
    // TITULO DO MODAL FILTRO
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Preferências de busca',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
            fontSize: 15,
            color: Color(0xffFF623E),
          ),
        ),
        Row(
          // RESETAR
          children: [
            TextButton(
                onPressed: () {
                  resetarAll();
                },
                child: Text(
                  'Resetar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Color(0xff7e8a8c),
                  ),
                )),
            SizedBox(width: 15),
            Icon(Icons.arrow_back_ios_rounded, color: Color(0xffFF623E)),
            SizedBox(width: 15),
          ],
        ),
      ],
    );
  }

  Widget _buildShowResultsButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          buildSearch();
        },
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
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.grey.shade300, width: 1.5), // BOTAO DE CIMA
          ),
          child: Row(
            children: [
              if (icon != null) Icon(icon, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: title == 'Buscar pet por nome'
                      ? controllerNome
                      : controllerCidade,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title == 'Buscar pet por nome'
                        ? 'Pesquisar'
                        : 'Todas as cidades',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: title == 'Digite a cidade de Goiás'
                          ? Color(0xFFFF623E)
                          : Color(
                              0xff8d8d8d), // Update color for 'Todas as cidades'
                    ),
                  ),
                ),
              ),
            ],
          ),
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

class CidadeOptions extends StatefulWidget {
  @override
  _CidadeOptionsState createState() => _CidadeOptionsState();
}

class _CidadeOptionsState extends State<CidadeOptions> {
  String _selectedCidade = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildCidadeButton('Pequeno'),
        SizedBox(width: 10),
        _buildCidadeButton('Médio'),
        SizedBox(width: 10),
        _buildCidadeButton('Grande'),
      ],
    );
  }

  Widget _buildCidadeButton(String cidades) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedCidade == cidades
              ? _selectedCidade = ""
              : _selectedCidade = cidades;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: _selectedCidade != cidades
              ? BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.2))
              : BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0)),
        ),
        backgroundColor:
            _selectedCidade == cidades ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        cidades,
        style: TextStyle(
          color: _selectedCidade == cidades ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class GeneroOptions extends StatefulWidget {
  @override
  _GeneroOptionsState createState() => _GeneroOptionsState();
}

class _GeneroOptionsState extends State<GeneroOptions> {
  String _selectedGenero = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildGeneroButton('Macho'),
        SizedBox(width: 10),
        _buildGeneroButton('Fêmea'),
      ],
    );
  }

  Widget _buildGeneroButton(String generos) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedGenero == generos
              ? _selectedGenero = ""
              : _selectedGenero = generos;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: _selectedGenero != generos
              ? BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.2))
              : BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0)),
        ),
        backgroundColor:
            _selectedGenero == generos ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        generos,
        style: TextStyle(
          color: _selectedGenero == generos ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class EspecieOptions extends StatefulWidget {
  @override
  _EspecieOptionsState createState() => _EspecieOptionsState();
}

class _EspecieOptionsState extends State<EspecieOptions> {
  String _selectedEspecie = '';

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

  Widget _buildSpeciesButton(String especies) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedEspecie == especies
              ? _selectedEspecie = ""
              : _selectedEspecie = especies;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: _selectedEspecie != especies
              ? BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.2))
              : BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0)),
        ),
        backgroundColor:
            _selectedEspecie == especies ? Color(0xFFFF623E) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        especies,
        style: TextStyle(
          color: _selectedEspecie == especies ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
