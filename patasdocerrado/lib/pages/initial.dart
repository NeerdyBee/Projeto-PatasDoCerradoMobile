import 'package:flutter/material.dart';
import 'package:patasdocerrado/components/my_petsupercard.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  List<ParseObject> results = <ParseObject>[];
  ParseUser? currentUser;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

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
    } else if (queryResponse.results != null && mounted) {
      setState(() {
        results = queryResponse.results as List<ParseObject>;
      });
    }
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
        body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF623E),
                        )),
                  );
                default:
                  return Stack(children: [
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
                                Text(
                                  'Bem vindo!',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Conheça seu novo melhor amigo!',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: PetSuperCard(pet: o),
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
                                                'Não há animais cadastrados no momento.',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ]);
              }
            }));
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
