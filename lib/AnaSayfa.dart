import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final double ekranyuksekligi;
  const HomeScreen({Key? key, required this.ekranyuksekligi, required this.onTabChange}) : super(key: key);
  final Function(int) onTabChange;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: ekranyuksekligi / 50),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'resimler/resimm.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: ekranyuksekligi / 50, top: ekranyuksekligi / 50),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: (){
                    onTabChange(1);
                  },
                  child: Image.asset(
                    'resimler/deneme.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: ekranyuksekligi / 100, bottom: ekranyuksekligi / 150),
                child: Text(
                  "Bölümler",
                  style: TextStyle(color: Color(0xFFBB86FC), fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: ekranyuksekligi / 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: ekranyuksekligi / 50, left: 10, bottom: 10),
                    child: Container(
                      height: ekranyuksekligi / 4,
                      width: ekranyuksekligi / 4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.2), // Hafif mor gölge
                            blurRadius: 3, // Yumuşaklık az
                            spreadRadius: 0, // Yanlardan yayılma yok
                            offset: Offset(0, 3), // Yalnızca aşağıya doğru
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A0E2D), Colors.black],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          "A1",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: ekranyuksekligi / 50, left: 10, bottom: 10),
                    child: Container(
                      height: ekranyuksekligi / 4,
                      width: ekranyuksekligi / 4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.2), // Hafif mor gölge
                            blurRadius: 3, // Yumuşaklık az
                            spreadRadius: 0, // Yanlardan yayılma yok
                            offset: Offset(0, 3), // Yalnızca aşağıya doğru
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A0E2D), Colors.black],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          "A2",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: ekranyuksekligi / 50, left: 10, bottom: 10),
                    child: Container(
                      height: ekranyuksekligi / 4,
                      width: ekranyuksekligi / 4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.2), // Hafif mor gölge
                            blurRadius: 3, // Yumuşaklık az
                            spreadRadius: 0, // Yanlardan yayılma yok
                            offset: Offset(0, 3), // Yalnızca aşağıya doğru
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A0E2D),Colors.black],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          "B1",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: ekranyuksekligi / 50, left: 10, bottom: 10),
                    child: Container(
                      height: ekranyuksekligi / 4,
                      width: ekranyuksekligi / 4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.2), // Hafif mor gölge
                            blurRadius: 3, // Yumuşaklık az
                            spreadRadius: 0, // Yanlardan yayılma yok
                            offset: Offset(0, 3), // Yalnızca aşağıya doğru
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A0E2D), Colors.black],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          "B3",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                        ),
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}