import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'dart:ui';

class PetSuperCard extends StatefulWidget {
  final ParseObject? pet;

  PetSuperCard({super.key, required this.pet});

  @override
  _PetSuperCardState createState() => _PetSuperCardState();
}

class _PetSuperCardState extends State<PetSuperCard> {
  bool isFavorite = false;
  String _cidade = "";
  String _genero = "";
  String _imgURL = "";
  int _idade = 0;
  String _tipoIdade = "";
  Future<void> getCidade(ParseObject? p) async {
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo('objectId', p?.get('animal_cidade').get('objectId'));
    ParseResponse response = await cidadeQuery.query();
    final String c = response.results?.first.get('nome');
    setState(() => _cidade = c);
  }

  Future<void> getGenero(ParseObject? p) async {
    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereEqualTo('objectId', p?.get('animal_genero').get('objectId'));
    ParseResponse response = await generoQuery.query();
    final String g = response.results?.first.get('nome');
    setState(() => _genero = g);
  }

  Future<void> getTipoIdade(ParseObject? p) async {
    QueryBuilder<ParseObject> tipoIdadeQuery = QueryBuilder<ParseObject>(
        ParseObject('TipoIdade'))
      ..whereEqualTo('objectId', p?.get('animal_tipoIdade').get('objectId'));
    ParseResponse response = await tipoIdadeQuery.query();
    final String t = response.results?.first.get('nome');
    setState(() => _tipoIdade = t);
  }

  @override
  void initState() {
    super.initState();
    getGenero(widget.pet);
    getCidade(widget.pet);
    _imgURL = widget.pet?.get("foto").get("url");
    _idade = widget.pet?.get("idade");
    getTipoIdade(widget.pet);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 322,
          height: 368,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(_imgURL),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: _buildBlurEffect(widget),
        ),
      ],
    );
  }

  Widget _buildBlurEffect(PetSuperCard pet) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: CardDetails(pet, _cidade, _genero, _idade, _tipoIdade),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  late final PetSuperCard pet;
  late final String cidade;
  late final String genero;
  late final int idade;
  late final String tipoIdade;
  CardDetails(PetSuperCard widget, String c, String g, int i, String t,
      {super.key}) {
    pet = widget;
    cidade = c;
    genero = g;
    idade = i;
    tipoIdade = t;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 322,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pet.pet?.get('nome'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFFFF623E),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/petprofile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF623E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
              ],
            ),
            Text(
              '$cidade, Goiás',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Color(0xFF8d8d8d),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                InfoRow(
                    icon: genero == "Macho" ? Icons.male : Icons.female,
                    label: genero),
                SizedBox(width: 16),
                InfoRow(
                    icon: Icons.access_time,
                    label: tipoIdade == "Anos"
                        ? idade != 1
                            ? "$idade $tipoIdade"
                            : "$idade Mês"
                        : idade != 1
                            ? "$idade $tipoIdade"
                            : "$idade Ano"),
              ],
            ),
          ],
        ),
      ),
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
