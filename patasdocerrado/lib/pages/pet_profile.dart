import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class PetProfilePage extends StatelessWidget {
  ParseObject? pet;
  PetProfilePage(ParseObject? p, {super.key}) {
    pet = p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DogImageComponent(pet),
    );
  }
}

class DogImageComponent extends StatefulWidget {
  ParseObject? pet;
  DogImageComponent(ParseObject? p, {super.key}) {
    pet = p;
  }

  @override
  _DogImageComponentState createState() => _DogImageComponentState();
}

class _DogImageComponentState extends State<DogImageComponent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isBoxVisible = false;
  bool _isFavorite = false;
  String _donoNome = "";
  String _donoCidade = "";
  String _donoTelefone = "";
  String _donoEmail = "";
  String _donoImgURL = "";
  String _genero = "";
  String _imgURL = "";
  ParseObject? favorito;

  Future<void> getGenero(ParseObject? p) async {
    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereEqualTo('objectId', p?.get('animal_genero').get('objectId'));
    ParseResponse response = await generoQuery.query();
    final String g = response.results?.first.get('nome');
    setState(() => _genero = g);
  }

  Future<void> getDonoInfo(ParseObject? p) async {
    QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo('objectId', p?.get('animal_dono').get('objectId'));
    ParseResponse response = await donoQuery.query();
    final String n = response.results?.first.get('nome');
    final String t = response.results?.first.get('telefone');
    final String e = response.results?.first.get('email');
    final String f = response.results?.first.get('foto').get('url');
    final String cId =
        response.results?.first.get('dono_cidade').get('objectId');
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo('objectId', cId);
    ParseResponse responseCidade = await cidadeQuery.query();
    final String c = responseCidade.results?.first.get('nome');
    setState(() => _donoCidade = c);
    setState(() => _donoNome = n);
    setState(() => _donoTelefone = t);
    setState(() => _donoEmail = e);
    setState(() => _donoImgURL = f);
  }

  Future<void> getFavorito(ParseObject? p) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo('dono_usuario', currentUser);
    ParseResponse donoResponse = await donoQuery.query();
    final dynamic d = donoResponse.results?.first;
    QueryBuilder<ParseObject> favoritoQuery =
        QueryBuilder<ParseObject>(ParseObject('Favorito'))
          ..whereEqualTo('favorito_animal', p)
          ..whereEqualTo('favorito_dono', d);
    ParseResponse favoritoResponse = await favoritoQuery.query();
    if (favoritoResponse.results == null) {
      setState(() => _isFavorite = false);
      return;
    } else {
      final dynamic f = favoritoResponse.results?.first;
      setState(() => _isFavorite = true);
      setState(() => favorito = f);
    }
  }

  @override
  void initState() {
    super.initState();
    getDonoInfo(widget.pet);
    getFavorito(widget.pet);
    _imgURL = widget.pet?.get("foto").get("url");
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBox() {
    setState(() {
      if (_isBoxVisible) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isBoxVisible = !_isBoxVisible;
    });
  }

  void _toggleFavorite(ParseObject? p) async {
    if (_isFavorite) {
      await favorito?.delete();
      favorito = null;
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } else {
      ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
      QueryBuilder<ParseObject> donoQuery =
          QueryBuilder<ParseObject>(ParseObject('Dono'))
            ..whereEqualTo('dono_usuario', currentUser);
      ParseResponse donoResponse = await donoQuery.query();
      final dynamic d = donoResponse.results?.first;
      final _favorito = ParseObject("Favorito")
        ..set("favorito_animal", p)
        ..set("favorito_dono", d);
      await _favorito.save();
      setState(() {
        favorito = _favorito;
      });
      setState(() {
        _isFavorite = !_isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _donoImgURL != ""
        ? Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.network(
                  _imgURL,
                  width: MediaQuery.of(context).size.width,
                  height: 460,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Align(
                // BOX PRINCIPAL BRANCO
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.57,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),

                  // BOTÃO FAVORITO
                  child: Stack(
                    children: [
                      DogAdoptionComponent(_toggleBox, widget.pet),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 420,
                right: 25,
                child: IconButton(
                  onPressed: () => _toggleFavorite(widget.pet),
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.grey,
                    size: 30.0, // Tamanho do ícone
                  ),
                ),
              ),
              // CAIXA ANIMADA
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut, // CURVA SUAVE PARA A ANIMAÇÃO
                bottom: _isBoxVisible
                    ? 0
                    : -570, // A CAIXA FICA VISÍVEL OU DESAPARECE
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 568, // ALTURA DA CAIXA
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
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
                                text:
                                    'Gostou ${_genero == "Macho" ? "do" : "da"} ${widget.pet?.get('nome')}?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: Color(0xFFFF5239),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _toggleBox,
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
                        SizedBox(height: 4),
                        // TEXTO INFORMATIVO SOBRE ADOÇÃO
                        Text(
                          'Para adotar esse pet ou saber mais sobre ${_genero == "Macho" ? "ele" : "ela"}, entre em contato com o protetor;',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xFF7E8A8C),
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
                                      NetworkImage(_donoImgURL), // FOTO DO DONO
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 7),
                                    Text(
                                      _donoNome, // NOME DO DONO
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xFFFF623E),
                                      ),
                                    ),
                                    SizedBox(height: 2),

                                    Text(
                                      '$_donoCidade, Goias',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Color(0x8A808080),
                                      ),
                                    ),
                                    SizedBox(height: 32),
                                    // TELEFONE DO DONO
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.chat,
                                          color: Color(0xFFFF5239),
                                          size: 30,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          _donoTelefone,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(199, 16, 16, 32),
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
                                          size: 30,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          _donoEmail,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                199, 16, 16, 32),
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
                        SizedBox(height: 50),
                        // TEXTINHO
                        Center(
                          child: Text(
                            'Adote com responsabilidade',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xFFFF5239),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // TEXTINHO LONGO
                        Text(
                          '"Adote com responsabilidade, pois um gesto de amor pode mudar duas vidas para sempre."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            height: 1.8,
                            color: Color(0xFF7e8a8c),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Color(0xFFFF623E),
                )),
          );
  }
}

class DogAdoptionComponent extends StatefulWidget {
  late VoidCallback onAdoptClicked;
  ParseObject? pet;

  DogAdoptionComponent(VoidCallback adoptClick, ParseObject? p, {super.key}) {
    onAdoptClicked = adoptClick;
    pet = p;
  }
  @override
  _DogAdoptionComponentState createState() => _DogAdoptionComponentState();
}

class _DogAdoptionComponentState extends State<DogAdoptionComponent> {
  String _donoNome = "";
  String _donoCidade = "";
  String _donoImgURL = "";
  String _cidade = "";
  String _genero = "";
  String _tipoIdade = "";
  String _porte = "";
  int _idade = 0;
  Future<void> getGenero(ParseObject? p) async {
    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereEqualTo('objectId', p?.get('animal_genero').get('objectId'));
    ParseResponse response = await generoQuery.query();
    final String g = response.results?.first.get('nome');
    setState(() => _genero = g);
  }

  Future<void> getCidade(ParseObject? p) async {
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo('objectId', p?.get('animal_cidade').get('objectId'));
    ParseResponse responseCidade = await cidadeQuery.query();
    final String c = responseCidade.results?.first.get('nome')!;
    setState(() => _cidade = c);
  }

  Future<void> getPorte(ParseObject? p) async {
    QueryBuilder<ParseObject> porteQuery =
        QueryBuilder<ParseObject>(ParseObject('Porte'))
          ..whereEqualTo('objectId', p?.get('animal_porte').get('objectId'));
    ParseResponse response = await porteQuery.query();
    final String prt = response.results?.first.get('nome');
    setState(() => _porte = prt);
  }

  Future<void> getTipoIdade(ParseObject? p) async {
    QueryBuilder<ParseObject> tipoIdadeQuery = QueryBuilder<ParseObject>(
        ParseObject('TipoIdade'))
      ..whereEqualTo('objectId', p?.get('animal_tipoIdade').get('objectId'));
    ParseResponse response = await tipoIdadeQuery.query();
    final String t = response.results?.first.get('nome');
    setState(() => _tipoIdade = t);
  }

  Future<void> getDonoInfo(ParseObject? p) async {
    QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject("Dono"))
          ..whereEqualTo("objectId", p!.get("animal_dono").get("objectId"));
    ParseResponse response = await donoQuery.query();
    final String n = response.results?.first.get('nome');
    final String f = response.results?.first.get('foto').get('url');
    setState(() => _donoNome = n);
    setState(() => _donoImgURL = f);
    final String cId =
        response.results?.first.get('dono_cidade').get("objectId");
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo('objectId', cId);
    ParseResponse responseCidade = await cidadeQuery.query();
    final String c = responseCidade.results?.first.get('nome');
    setState(() => _donoCidade = c);
  }

  @override
  void initState() {
    super.initState();
    getGenero(widget.pet);
    getCidade(widget.pet);
    getPorte(widget.pet);
    _idade = widget.pet?.get("idade");
    getTipoIdade(widget.pet);
    getDonoInfo(widget.pet);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: _donoNome != "" &&
                _donoCidade != "" &&
                _donoImgURL != "" &&
                _cidade != "" &&
                _genero != "" &&
                _tipoIdade != "" &&
                _porte != ""
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      // NOME DO CÃO
                      RichText(
                        text: TextSpan(
                          text: "${widget.pet!.get("nome")}", // NOME DO CÃO
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Color(0xFFFF623E),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5),
                      // LOCALIZAÇÃO DO CÃO
                      Row(children: [
                        Icon(
                          Icons
                              .location_on_outlined, // Ícone de localização vazado
                          color: Color.fromARGB(
                              255, 204, 204, 204), // Cor do ícone
                          size: 14, // Tamanho do ícone, o mesmo do texto
                        ),
                        SizedBox(width: 0),
                        Text(
                          '$_cidade, Goias', // LOCALIZAÇÃO
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color.fromARGB(255, 166, 166, 166),
                          ),
                        ),
                      ]),
                      SizedBox(height: 28),
                      // INFORMAÇÕES PRINCIPAIS DO CÃO
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoCard(
                              title: 'Idade',
                              info: _tipoIdade == "Anos"
                                  ? _idade != 1
                                      ? "$_idade $_tipoIdade"
                                      : "$_idade Mês"
                                  : _idade != 1
                                      ? "$_idade $_tipoIdade"
                                      : "$_idade Ano"),
                          SizedBox(width: 40),
                          InfoCard(title: 'Sexo', info: _genero),
                          SizedBox(width: 40),
                          InfoCard(title: 'Porte', info: _porte),
                        ],
                      ),
                      SizedBox(height: 28),
                      Text(
                        'Conheça minha história',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xFFFF623E),
                        ),
                      ),
                      SizedBox(height: 2),
                      DogDetailsComponent(widget.pet),
                      SizedBox(height: 15),
                      OwnerCard(
                        nome: _donoNome,
                        cidade: '$_donoCidade, Goias',
                        imgUrl: _donoImgURL,
                      ),
                      SizedBox(height: 20),
                      Center(
                        // BOTÃO PARA ADOTAR O CÃO
                        child: GestureDetector(
                          onTap: widget.onAdoptClicked,
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF5239),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
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
                      )
                    ]))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF623E),
                      )),
                ),
              ));
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String info;

  InfoCard({required this.title, required this.info});
  //CARDIZINHOS
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 22),
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
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Color(0xFFFF623E),
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
  final String nome;
  final String cidade;
  final String imgUrl;

  OwnerCard({required this.nome, required this.cidade, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0x0FFFFF5ED),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // AVATAR DO DONO
          CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(imgUrl),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NOME DO DONO
              Text(
                nome,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFFFF5239),
                ),
              ),
              // LOCALIZAÇÃO DO DONO
              Text(
                cidade,
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
  late ParseObject? pet;
  DogDetailsComponent(ParseObject? p) {
    pet = p;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Text(
        "${pet!.get("descricao")}",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w100,
          fontSize: 14,
          height: 1.8,
          color: Color(0xFF7E8A8C),
        ),
      ),
    );
  }
}
