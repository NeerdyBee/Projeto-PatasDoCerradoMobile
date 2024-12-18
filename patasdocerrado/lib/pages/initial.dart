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
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined),
                        onPressed: () {},
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
                  child: Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final o = results[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: PetSuperCard(pet: o),
                          );
                        },
                      ),
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
