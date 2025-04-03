import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(
              flex: 3,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Hafif yuvarlatılmış
                image: DecorationImage(
                  image: AssetImage("resimler/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Speezy",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080)),
            ),
            Spacer(
              flex: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF000080),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15), // İç boşluk
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold), // Yazı stili
                      ),
                      child: Text("Hemen başla"),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
