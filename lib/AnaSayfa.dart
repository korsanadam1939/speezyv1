import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy/kelime.dart';
import 'package:speezy/kelimelerdao.dart';

class HomeScreen extends StatefulWidget {
  final double ekranyuksekligi;
  final Function(int) onTabChange;


  const HomeScreen({Key? key, required this.ekranyuksekligi, required this.onTabChange}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int ogrenilenkelimesayisi = 0;


  double _progress = 0.0;
  @override
  void initState() {
    super.initState();
    //_startProgress();
    ogrenilenkelimelerioku();
  }



  Future<void> ogrenilenkelimelerioku() async {
    var sp = await SharedPreferences.getInstance();



    setState(() {
      ogrenilenkelimesayisi = sp.getInt("ogrenilensayisi") ?? 0;
      _progress = ogrenilenkelimesayisi/22;
    });





  }



  void _startProgress() {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: widget.ekranyuksekligi / 50,bottom: widget.ekranyuksekligi/40),
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

            padding: EdgeInsets.only(left: 10, right: 10,bottom: widget.ekranyuksekligi/45),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigoAccent, Color(0xFF000080)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight, 
                ),
                borderRadius: BorderRadius.circular(8), // Köşeleri yuvarlatma
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text("Merhaba Erdem",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: LinearProgressIndicator(
                        value: _progress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text("$ogrenilenkelimesayisi/22 Kelime öğrenildi",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white70),)

                  ],
                ),
              ),
            ),
          ),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: widget.ekranyuksekligi / 100, bottom: widget.ekranyuksekligi / 150),
                child: Text(
                  "Bölümler",
                  style: TextStyle(color: Color(0xFFBB86FC), fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.ekranyuksekligi / 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (index) {
                  List<String> levels = ["A1", "A2", "B1", "B2"];
                  return Padding(
                    padding: EdgeInsets.only(right: widget.ekranyuksekligi / 50, left: 10, bottom: 10),
                    child: Container(
                      height: widget.ekranyuksekligi / 4,
                      width: widget.ekranyuksekligi / 4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.2),
                            blurRadius: 3,
                            spreadRadius: 0,
                            offset: Offset(0, 3),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A0E2D), Colors.black],
                          stops: [0, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          levels[index],
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
