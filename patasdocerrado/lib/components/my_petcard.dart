import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class PetCard extends StatefulWidget {
  final ParseObject? pet;
  late ParseObject? p;
  late ParseObject? cidade;
  late ParseObject? genero;
  void queryCidade(ParseObject? pet) async {
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereRelatedTo('animal_cidade', 'Animal', pet!.objectId!);
    ParseResponse cidadeResponse = await cidadeQuery.query();
    cidade = cidadeResponse.results?.first as ParseObject;
  }

  void queryGenero(ParseObject? pet) async {
    QueryBuilder<ParseObject> generoQuery =
        QueryBuilder<ParseObject>(ParseObject('Genero'))
          ..whereRelatedTo('animal_genero', 'Animal', pet!.objectId!);
    ParseResponse generoResponse = await generoQuery.query();
    genero = generoResponse.results?.first as ParseObject;
  }

  PetCard({super.key, required this.pet}) {
    p = pet;
    cidade;
    genero;
    queryCidade(pet);
    queryGenero(pet);
  }
  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage("assets/dog01.jpg"),
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
                          '${widget.cidade?.get('nome')}, Goias',
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
                                icon: Icons.male,
                                label: '${widget.cidade?.get('nome')}'),
                            SizedBox(width: 16),
                            InfoRow(icon: Icons.access_time, label: '2 Anos'),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {},
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
        right: 32,
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    ]);
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
