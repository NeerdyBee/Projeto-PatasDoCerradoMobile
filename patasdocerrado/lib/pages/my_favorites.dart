import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:patasdocerrado/components/my_petcard.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({super.key});
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  List<ParseObject> results = <ParseObject>[];
  ParseUser? currentUser;
  ParseObject? currentDono;
  Future<void> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    getDono();
  }

  Future<void> getDono() async {
    QueryBuilder<ParseObject> donoQuery =
        QueryBuilder<ParseObject>(ParseObject('Dono'))
          ..whereEqualTo('dono_usuario', currentUser);
    ParseResponse response = await donoQuery.query();
    setState(() => currentDono = response.results?.first);
    doQueryMatches();
  }

  void doQueryMatches() async {
    final QueryBuilder<ParseObject> favoritoQuery =
        QueryBuilder<ParseObject>(ParseObject('Favorito'))
          ..whereEqualTo('favorito_dono', currentDono);
    final QueryBuilder<ParseObject> petQuery =
        QueryBuilder<ParseObject>(ParseObject('Animal'))
          ..orderByDescending('createdAt');
    final ParseResponse favoritosResponse = await favoritoQuery.query();
    final ParseResponse petResponse = await petQuery.query();
    print(currentDono);
    print(currentUser);
    print(favoritosResponse.results);
    if ((!petResponse.success ||
            petResponse.results == null ||
            favoritosResponse.results == null) &&
        mounted) {
      setState(() {
        results.clear();
      });
    } else if (mounted) {
      List<ParseObject> r = <ParseObject>[];
      for (var obj in favoritosResponse.results!) {
        print(obj);
        for (var p in petResponse.results!) {
          if (obj.get('favorito_animal').get('objectId') == p.get('objectId')) {
            print("Pet add: $p");
            r.add(p);
          }
        }
      }
      setState(() {
        results = r;
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
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFFF623E),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Meus Favoritos!',
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
                        'Não esqueça da gente',
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
                  child: Stack(children: [
                    _buildPetList(),
                    // Fade overlays
                    _buildFadeOverlay(top: true),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final o = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PetCard(pet: o, isFavoritos: true),
        );
      },
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
