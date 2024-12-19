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

  void doQueryMatches() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    final QueryBuilder<ParseObject> userQuery =
        QueryBuilder<ParseObject>(ParseObject('_User'))
          ..whereEqualTo("objectId", currentUser?.objectId);
    final QueryBuilder<ParseObject> petQuery =
        QueryBuilder<ParseObject>(ParseObject('Animal'))
          ..orderByDescending('createdAt')
          ..whereMatchesQuery("animal_usuario", userQuery);
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
    return MaterialApp(
        debugShowCheckedModeBanner: false, // Desativa o debug banner
        home: Scaffold(
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
                              onPressed: () => Navigator.of(context).pop()),
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
                        child: Stack(children: [
                      _buildPetList(),
                      // Fade overlays
                      _buildFadeOverlay(top: true),
                      _buildFadeOverlay(top: false),
                    ])),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingButtonWithText(),
              ),
            ],
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

class FloatingButtonWithText extends StatefulWidget {
  @override
  _FloatingButtonWithTextState createState() => _FloatingButtonWithTextState();
}

class _FloatingButtonWithTextState extends State<FloatingButtonWithText> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true; // Pressionado
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false; // Soltou o toque
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false; // Caso o toque seja cancelado
        });
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
              scale:
                  _isPressed ? 0.9 : 1.0, // Reduz o tamanho quando pressionado
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
}
