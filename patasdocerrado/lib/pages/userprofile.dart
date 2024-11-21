import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  ParseUser? currentUser;
  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<ParseUser?>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          SizedBox(height: 18),
                          Text(
                            ('${snapshot.data!.username}'),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFFFF623E),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: [
                                buildMenuButton(context, Icons.manage_accounts,
                                    'Configuração de perfil', '/editprofile'),
                                buildMenuButton(context, Icons.pets_outlined,
                                    'Adotaveis', '/my_adoptables',
                                    outline: true),
                                buildMenuButton(context, Icons.favorite,
                                    'Meus favoritos', '/my_favorites'),
                                buildMenuButton(context, Icons.lock,
                                    'Alterar senha', '/recoverpswdpage',
                                    outline: true),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF623E),
                              minimumSize: Size(123, 36),
                            ),
                            onPressed: () => doUserLogout(),
                            child: Text(
                              'Sair da conta',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }
            }));
  }

  Widget buildMenuButton(
      BuildContext context, IconData icon, String text, String page,
      {bool outline = false}) {
    final iconColor = Color.fromRGBO(137, 150, 157, 1);

    return GestureDetector(
        // When the child is tapped, show a snackbar.
        onTap: () => Navigator.pushNamed(context, page),
        // The custom button
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: Color.fromARGB(255, 223, 223, 223), width: 2),
          ),
          width: 400,
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (outline)
                Stack(
                  children: [
                    Icon(icon, size: 26, color: Colors.white),
                    Icon(icon, size: 26, color: iconColor.withOpacity(0.8)),
                  ],
                )
              else
                Icon(icon, size: 26, color: iconColor),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: iconColor,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: iconColor),
            ],
          ),
        ));
  }

  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }

    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  void showSuccess(message) {
    var content = message;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Concluído!"),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro!"),
            content: Text(errorMessage),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void doUserLogout() async {
    var response = await currentUser!.logout();
    if (response.success) {
      showSuccess('Usuário deslogado!');
    } else {
      showError(response.error!.message);
    }
  }
}
