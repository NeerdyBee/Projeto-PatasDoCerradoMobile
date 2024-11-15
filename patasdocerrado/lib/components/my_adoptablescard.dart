import 'package:flutter/material.dart';

class AdoptablesCard extends StatefulWidget {
  final String imageName;

  const AdoptablesCard({required this.imageName});

  @override
  _AdoptablesCardState createState() => _AdoptablesCardState();
}

class _AdoptablesCardState extends State<AdoptablesCard> {
  bool isFavorite = false;

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
                      image: AssetImage(widget.imageName),
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
                          'Pascal',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFFFF623E),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          'Rialma, Goias',
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
                            InfoRow(icon: Icons.male, label: 'Macho'),
                            SizedBox(width: 16),
                            InfoRow(icon: Icons.access_time, label: '3 Anos'),
                          ],
                        ),
                      ],
                    ),
                    // Usando Row para alinhar os botões
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Botão "Status de adoção" ajustado um pouco à esquerda
                        ElevatedButton(
                          onPressed: () {},
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
                          onTap: () {
                            print("Botão da engrenagem pressionado");
                          },
                          splashColor:
                              Colors.white.withOpacity(0.5), // Efeito de splash
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
        right: 35,
        child: IconButton(
          icon: Icon(
            Icons.delete_outline, // Ícone de lixeira (não preenchido)
            color: Colors.grey, // Cor do ícone
            size: 24, // Tamanho do ícone
          ),
          onPressed: () {
            // Ação ao clicar no ícone de lixeira
            print("Lixeira clicada!");
          },
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
        Icon(icon, size: 13, color: Color(0xFF8d8d8d)),
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
