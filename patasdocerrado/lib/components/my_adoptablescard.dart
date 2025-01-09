import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:patasdocerrado/pages/edit_pet.dart';

class MyAdoptablesCard extends StatefulWidget {
  ParseObject? pet;

  MyAdoptablesCard({super.key, required this.pet});

  @override
  _MyAdoptablesCardState createState() => _MyAdoptablesCardState();
}

class _MyAdoptablesCardState extends State<MyAdoptablesCard> {
  bool isFavorite = false;
  String _cidade = "";
  String _genero = "";
  String _imgURL = "";
  int _idade = 0;
  String _tipoIdade = "";
  String _statusAdocao = "";
  late ParseObject favorito;
  Future<void> getCidade(ParseObject? p) async {
    QueryBuilder<ParseObject> cidadeQuery =
        QueryBuilder<ParseObject>(ParseObject('Cidade'))
          ..whereEqualTo('objectId', p?.get('animal_cidade').get('objectId'));
    ParseResponse response = await cidadeQuery.query();
    final String c = response.results?.first.get('nome');
    setState(() => _cidade = c);
  }

  Future<void> getStatusAdocao(ParseObject? p) async {
    QueryBuilder<ParseObject> cidadeQuery = QueryBuilder<ParseObject>(
        ParseObject('StatusAdocao'))
      ..whereEqualTo('objectId', p?.get('animal_statusAdocao').get('objectId'));
    ParseResponse response = await cidadeQuery.query();
    final String sA = response.results?.first.get('nome');
    setState(() => _statusAdocao = sA);
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
    getStatusAdocao(widget.pet);
    _imgURL = widget.pet?.get("foto").get("url");
    _idade = widget.pet?.get("idade");
    getTipoIdade(widget.pet);
  }

  @override
  Widget build(BuildContext context) {
    return widget.pet != null
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
                                    "($_statusAdocao)",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Botão "Status de adoção" ajustado um pouco à esquerda
                                  ElevatedButton(
                                    onPressed: () {
                                      showStatusAdocao();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFF623E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      minimumSize: Size(140, 42),
                                    ),
                                    child: Text(
                                      'Status de adoção',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6), // Espaço entre os botões
                                  // Botão pequeno à direita do "Status de adoção"
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditPetPage(widget.pet))),
                                    splashColor: Colors.white
                                        .withOpacity(0.5), // Efeito de splash
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF032437),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.settings_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
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
                // Ícone de lixeira no canto superior direito
                Positioned(
                  top: 5,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline, // Ícone de lixeira (não preenchido)
                      color: Colors.grey, // Cor do ícone
                      size: 24, // Tamanho do ícone
                    ),
                    onPressed: () => showDelete(),
                  ),
                ),
              ])
            : Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF623E),
                    )),
              )
        : SizedBox(
            height: 0,
          );
  }

  void deletePet() async {
    await widget.pet!.delete();
    setState(() {
      widget.pet = null;
    });
  }

  void updateStatusAdocao(String status) async {
    QueryBuilder<ParseObject> statusAdocaoQuery =
        QueryBuilder(ParseObject('StatusAdocao'))..whereEqualTo('nome', status);
    ParseResponse statusAdocaoResponse = await statusAdocaoQuery.query();
    widget.pet!.set('animal_statusAdocao', statusAdocaoResponse.results!.first);
    widget.pet!.save();
    setState(() {
      _statusAdocao = statusAdocaoResponse.results!.first.get("nome");
    });
  }

  void showStatusAdocao() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Status de adoção"),
          content: const Text("Selecione os Status de adoção do seu pet:"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Para Adoção"),
              onPressed: () {
                Navigator.of(context).pop();
                updateStatusAdocao("Para adoção");
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll<Color>(Color(0xFFFF623E)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                updateStatusAdocao("Adotado");
              },
              child: const Text("Adotado"),
            ),
          ],
        );
      },
    );
  }

  void showDelete() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deletar pet"),
          content: const Text("Deseja excluir seu pet?"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop();
                deletePet();
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll<Color>(Color(0xFFFF623E)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Não"),
            ),
          ],
        );
      },
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
