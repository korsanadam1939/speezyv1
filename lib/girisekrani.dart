import 'package:flutter/material.dart';
import 'package:speezy/Oyun.dart';
import 'package:speezy/bolumler.dart';
import 'package:speezy/kelimelerdao.dart';
import 'package:speezy/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class girisekrani extends StatefulWidget {
  const girisekrani({super.key});

  @override
  State<girisekrani> createState() => _girisekraniState();
}

class _girisekraniState extends State<girisekrani> {
  var tfkullaniciadi =TextEditingController();
  var tfseviye = TextEditingController();
  var scaffoldKey =GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async{
    var ka =tfkullaniciadi.text;
    var s =tfseviye.text;

    if(ka.isNotEmpty && s.isNotEmpty){

      var sp =await SharedPreferences.getInstance();
      await sp.setString("kullaniciadi", ka);
      await sp.setString("seviye", s);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>MyHomePage()
        ),
      );






    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş hatalı")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Ekranın boyutları
    var screenWidth = screenSize.width; // Ekran genişliği
    var screenHeight = screenSize.height; // Ekran yüksekliği
    return Scaffold(



      backgroundColor: Color(0xFF121212),


      body:  SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: screenWidth/1,
                height: screenHeight/1.8,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.2),  // Gölgenin rengi
                      offset: Offset(4, 4),  // Gölgenin yerleşim pozisyonu (x, y)
                      blurRadius: 10,  // Gölgenin bulanıklık derecesi
                      spreadRadius: 2,  // Gölgenin yayılma derecesi
                    ),
                  ],
        
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)// Resmin sadece sol üst köşesini ovalleştir
                  ),
                  child: Image.asset(
                    "resimler/s.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
        
                padding: const EdgeInsets.only(top: 30,right: 10,left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurpleAccent.withOpacity(0.2),
                        offset: Offset(4, 4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: tfkullaniciadi,
                    decoration: InputDecoration(
                      labelText: 'isim',
                      labelStyle: TextStyle(color: Colors.white),// Etiket
                      hintText: 'Adınızı girin', // Yardımcı metin
                      hintStyle: TextStyle(color: Colors.white,),
                       // Sol tarafta ikon
                      border: OutlineInputBorder( // Kenarlık tipi
                        borderRadius: BorderRadius.circular(10), // Kenarlık yuvarlama
                      ),
                      prefixIcon: Icon(Icons.person_sharp,color: Colors.white,),
                      filled: true, // Arka plan rengini aktif et
                      fillColor: Colors.deepPurpleAccent, // Arka plan rengi
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
        
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
        
              Padding(
        
                padding: const EdgeInsets.only(top: 20,right: 10,left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurpleAccent.withOpacity(0.2),
                        offset: Offset(4, 4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: tfseviye,
                    readOnly: true, // Kullanıcı manuel yazamasın, sadece seçim yapsın
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Seviyenizi Seçin"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text("A1"),
                                  onTap: () {
                                    tfseviye.text = "A1";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("A2"),
                                  onTap: () {
                                    tfseviye.text = "A2";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("B1"),
                                  onTap: () {
                                    tfseviye.text = "B1";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("B2"),
                                  onTap: () {
                                    tfseviye.text = "B1";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("C1"),
                                  onTap: () {
                                    tfseviye.text = "B1";
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("C4 💣"),
                                  onTap: () {
                                    tfseviye.text = "B1";
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Seviye',
                      labelStyle: TextStyle(color: Colors.white), // Etiket
                      hintText: 'Seviyenizi giriniz',
                      hintStyle: TextStyle(color: Colors.white), // Yardımcı metin
                      border: OutlineInputBorder( // Kenarlık tipi
                        borderRadius: BorderRadius.circular(10), // Kenarlık yuvarlama
                      ),
                      prefixIcon: Icon(Icons.leaderboard, color: Colors.white),
                      filled: true, // Arka plan rengini aktif et
                      fillColor: Colors.deepPurpleAccent, // Arka plan rengi
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextButton(
                  child: Text("Hemen Başla",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                  onPressed: (){
                    girisKontrol();
                  },
                ),
              )
        
        
            ]
        
        ),
      ),


    );




  }
}
