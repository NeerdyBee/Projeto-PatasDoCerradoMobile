import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'dart:ui';

class PetSuperCard extends StatefulWidget {
  final ParseObject? pet;
  late ParseObject? cidade;
  late ParseObject? genero;

  ParseObject queryCidade(ParseObject? p) {
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereRelatedTo('animal_cidade', 'Animal', p!.objectId!);
    return (cidadeQuery.query() as ParseResponse).results?.first as ParseObject;
  }

  ParseObject queryGenero(ParseObject? p) {
    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereRelatedTo('animal_genero', 'Animal', p!.objectId!);
    ParseResponse generoResponse = generoQuery.query() as ParseResponse;
    return generoResponse.results?.first as ParseObject;
  }

  PetSuperCard({super.key, required this.pet}) {
    this.cidade = queryCidade(pet);
    this.genero = queryGenero(pet);
  }
  @override
  _PetSuperCardState createState() => _PetSuperCardState();
}

class _PetSuperCardState extends State<PetSuperCard> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
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
              image: AssetImage("assets/dog01.jpg"),
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
          child: _buildBlurEffect(),
        ),
      ],
    );
  }

  Widget _buildBlurEffect() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: CardDetails(widget),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  late final PetSuperCard pet;
  CardDetails(PetSuperCard widget) {
    pet = widget;
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
                  onPressed: () {},
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
              '${pet.cidade?.get('nome')}, Goiás',
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
                InfoRow(icon: Icons.male, label: '${pet.genero?.get('nome')}'),
                SizedBox(width: 16),
                InfoRow(icon: Icons.access_time, label: '2 Anos'),
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
