import 'package:flutter/material.dart';

class PetProfilePage extends StatelessWidget {
  const PetProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  Image.asset(
                    "../assets/dog04.jpg",
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(42),
                            topRight: Radius.circular(42),
                          ),
                          color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.arrow_back_ios_rounded),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Column(
                    children: [Text("Barto"), Text("Ceres-GO")],
                  ),
                  Icon(Icons.favorite_border,
                      color: Color.fromARGB(0, 255, 165, 106)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
