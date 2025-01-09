import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:patasdocerrado/pages/pet_profile.dart';

class PetCard extends StatefulWidget {
  final ParseObject? pet;
  final bool isFavoritos;
  PetCard({super.key, required this.pet, required this.isFavoritos});

  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  bool isFavorite = false;
  String _cidade = "";
  String _genero = "";
  String _imgURL = "";
  int _idade = 0;
  String _tipoIdade = "";
  ParseObject? favorito;
  Future<void> getCidade(ParseObject? p) async {
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo('objectId', p?.get('animal_cidade').get('objectId'));
    ParseResponse response = await cidadeQuery.query();
    final String c = response.results?.first.get('nome');
    if (response.results != null && mounted) setState(() => _cidade = c);
  }

  Future<void> getGenero(ParseObject? p) async {
    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereEqualTo('objectId', p?.get('animal_genero').get('objectId'));
    ParseResponse response = await generoQuery.query();
    final String g = response.results?.first.get('nome');
    if (response.results != null && mounted) setState(() => _genero = g);
  }

  Future<void> getTipoIdade(ParseObject? p) async {
    QueryBuilder<ParseObject> tipoIdadeQuery = QueryBuilder<ParseObject>(
        ParseObject('TipoIdade'))
      ..whereEqualTo('objectId', p?.get('animal_tipoIdade').get('objectId'));
    ParseResponse response = await tipoIdadeQuery.query();
    final String t = response.results?.first.get('nome');
    if (response.results != null && mounted) setState(() => _tipoIdade = t);
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
    if (favoritoResponse.results == null && mounted) {
      setState(() => isFavorite = false);
      return;
    } else if (mounted) {
      final dynamic f = favoritoResponse.results?.first;
      setState(() => isFavorite = true);
      setState(() => favorito = f);
    }
  }

  @override
  void initState() {
    super.initState();
    getGenero(widget.pet);
    getCidade(widget.pet);
    _imgURL = widget.pet?.get("foto").get("url");
    _idade = widget.pet?.get("idade");
    getTipoIdade(widget.pet);
    getFavorito(widget.pet);
  }

  void _toggleFavorite(ParseObject? p) async {
    if (isFavorite) {
      await favorito?.delete();
      favorito = null;
      setState(() {
        isFavorite = !isFavorite;
      });
      super.setState(() {});
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
        isFavorite = !isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFavoritos != true
        ? _cidade != "" && _tipoIdade != "" && _genero != ""
            ? Stack(alignment: Alignment.bottomCenter, children: [
                Container(
                  width: 400,
                  height: 188,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 178,
                            height: 188,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                image: NetworkImage(_imgURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 24.0, bottom: 16.0, top: 16.0, left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.pet?.get('nome'),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFFFF623E),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  Text(
                                    '$_cidade, Goiás',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: Color(0xFF8d8d8d),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InfoRow(
                                          icon: _genero == "Macho"
                                              ? Icons.male
                                              : Icons.female,
                                          label: _genero),
                                      SizedBox(width: 16),
                                      InfoRow(
                                          icon: Icons.access_time,
                                          label: _tipoIdade == "Anos"
                                              ? _idade != 1
                                                  ? "$_idade $_tipoIdade"
                                                  : "$_idade Mês"
                                              : _idade != 1
                                                  ? "$_idade $_tipoIdade"
                                                  : "$_idade Ano"),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PetProfilePage(widget.pet))),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF623E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(140, 42),
                                  ),
                                  child: Text(
                                    'Me adote!',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(widget.pet),
                  ),
                ),
              ])
            : Center(
                child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF623E),
                    )),
              )
        : !isFavorite
            ? SizedBox(
                height: 0,
              )
            : _cidade != "" && _tipoIdade != "" && _genero != ""
                ? Stack(alignment: Alignment.bottomCenter, children: [
                    Container(
                      width: 400,
                      height: 188,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 178,
                                height: 188,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    image: NetworkImage(_imgURL),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 24.0,
                                  bottom: 16.0,
                                  top: 16.0,
                                  left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.pet?.get('nome'),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(0xFFFF623E),
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        '$_cidade, Goiás',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Color(0xFF8d8d8d),
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InfoRow(
                                              icon: _genero == "Macho"
                                                  ? Icons.male
                                                  : Icons.female,
                                              label: _genero),
                                          SizedBox(width: 16),
                                          InfoRow(
                                              icon: Icons.access_time,
                                              label: _tipoIdade == "Anos"
                                                  ? _idade != 1
                                                      ? "$_idade $_tipoIdade"
                                                      : "$_idade Mês"
                                                  : _idade != 1
                                                      ? "$_idade $_tipoIdade"
                                                      : "$_idade Ano"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  PetProfilePage(widget.pet))),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFF623E),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        minimumSize: Size(140, 42),
                                      ),
                                      child: Text(
                                        'Me adote!',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleFavorite(widget.pet),
                      ),
                    ),
                  ])
                : Center(
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF623E),
                        )),
                  );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, size: 11, color: Color(0xFF8d8d8d)),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xFF8d8d8d),
          ),
        ),
      ],
    );
  }
}
