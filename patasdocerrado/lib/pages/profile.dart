import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                  'Pedro Fran',
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
                      buildMenuButton(context, Icons.pets_outlined, 'Adotaveis',
                          '/editprofile',
                          outline: true),
                      buildMenuButton(context, Icons.favorite, 'Meus favoritos',
                          '/editprofile'),
                      buildMenuButton(
                          context, Icons.lock, 'Alterar senha', '/editprofile',
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
                  onPressed: () => Navigator.pushNamed(context, '/login'),
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
        ));
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
}
