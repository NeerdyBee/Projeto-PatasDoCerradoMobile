import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:patasdocerrado/components/my_adoptablescard.dart';

class MyAdoptablesPage extends StatefulWidget {
  const MyAdoptablesPage({super.key});
  @override
  _MyAdoptablesPageState createState() => _MyAdoptablesPageState();
}

class _MyAdoptablesPageState extends State<MyAdoptablesPage> {
  List<ParseObject> results = <ParseObject>[];
  ParseUser? currentUser;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    getAdoptables();
    return currentUser;
  }

  void getAdoptables() async {
    final QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo('dono_usuario', currentUser);
    ParseResponse response = await donoQuery.query();
    final QueryBuilder<ParseObject> adoptablesQuery =
        QueryBuilder<ParseObject>(ParseObject('Animal'))
          ..orderByDescending('createdAt')
          ..whereEqualTo("animal_dono", response.results!.first as ParseObject);
    final ParseResponse queryResponse = await adoptablesQuery.query();
    if (!queryResponse.success || queryResponse.results == null) {
      setState(() {
        results.clear();
      });
    } else if (mounted) {
      setState(() {
        results = queryResponse.results as List<ParseObject>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // Desativa o debug banner
        home: Scaffold(
          backgroundColor: Colors.white,
          body: currentUser != null
              ? Stack(
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
                                Spacer(),
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xFFFF623E),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop()),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Adotáveis!',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Color(0xFFFF623E),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Veja seus pets para adoção',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                              child: results.isNotEmpty
                                  ? Stack(children: [
                                      _buildPetList(),
                                      // Fade overlays
                                      _buildFadeOverlay(top: true),
                                      _buildFadeOverlay(top: false),
                                    ])
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
                                                  'Não há animais cadastrados no momento.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                    )),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 20,
                      child: cadastrarPet(),
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
                ),
        ));
  }

  Widget _buildPetList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final o = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: MyAdoptablesCard(pet: o),
        );
      },
    );
  }

  Widget cadastrarPet() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/registerpet");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18), // Borda arredondada da caixa externa
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Cadastre um novo pet aqui!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Color(0xFF8D8D8D),
                height: 1.85,
              ),
            ),
            SizedBox(width: 10),
            // Efeito de toque no botão
            AnimatedScale(
              scale: 1.0, // Reduz o tamanho quando pressionado
              duration: Duration(milliseconds: 100), // Duração do efeito
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFF623E), // Cor laranja
                  borderRadius:
                      BorderRadius.circular(18), // Borda com raio de 18
                ),
                child: Icon(Icons.add, color: Colors.white, size: 45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFadeOverlay({required bool top}) {
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
