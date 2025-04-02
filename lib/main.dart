import 'package:flutter/material.dart';
import 'package:speezy/AnaSayfa.dart';
import 'package:speezy/Oyun.dart';
import 'package:speezy/bolumler.dart';
import 'package:speezy/game.dart';
import 'package:speezy/girisekrani.dart';
import 'package:speezy/kelime.dart';
import 'package:speezy/kelimelerdao.dart';
import 'package:speezy/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy/profil.dart';
import 'package:speezy/veritabaniyardimcisi.dart';


import 'package:iconsax/iconsax.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> oturumkontrol() async{

    var sp= await SharedPreferences.getInstance();


    String spKullaniciAdi=sp.getString("kullaniciadi"  ) ??"yok";
    String spSifre=sp.getString("seviye"  ) ??"yok";

    if(spKullaniciAdi=="yok" && spSifre=="yok"){
      return true;
    }
    else{
      return false;
    }


  }


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
          future: oturumkontrol(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              bool gecisizni = snapshot.data ?? false;
              return gecisizni ? girisekrani() : MyHomePage();

            }else{
              return Container();
            }
          }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Seçili menü öğesi
  late PageController _pageController; // Sayfa kontrolcüsü

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Sayfa değiştirildiğinde BottomNavigationBar'ı güncelle
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  // Sayfa kaydırıldığında BottomNavigationBar'ı güncelle
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ekranbilgisi = MediaQuery.of(context);
    double ekranyuksekligi = ekranbilgisi.size.height;

    // Sayfa Listesi
    final List<Widget> _pages = [
      HomeScreen(ekranyuksekligi: ekranyuksekligi, onTabChange: _onItemTapped),
      Oyun(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          setState(() {
            _selectedIndex=0; // Önceki sekmeye geç
          });
          _pageController.jumpToPage(_selectedIndex); // Sayfayı değiştir
          return false; // Uygulamadan çıkışı engelle
        }
        return true; // Eğer ilk sekmedeyse çıkışa izin ver
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF121212),
          leading: const Icon(Icons.tag_faces, color: Colors.white),
          title: const Text(
            "Speezy",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert_sharp),
              color: Colors.white,
              onPressed: () {},
            ),
            PopupMenuButton(
              iconColor: Colors.white,
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(child: Text('Bilgi')),
                  const PopupMenuItem(child: Text('Yardım'))
                ];
              },
            )
          ],
        ),
        backgroundColor: Color(0xFF121212),

        // **PageView ile içerik değişimi ve kaydırma**
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pages,
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Iconsax.home4), label: 'Ana Sayfa'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Öğren'),
            BottomNavigationBarItem(icon: Icon(Iconsax.profile_circle), label: 'Profil'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF121212),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
