
import 'package:speezy/Login-Register/loginscreen.dart';

import '../utils/file_importers.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  String? spKullaniciAdi;
  String? spSifre;

  // SharedPreferences'den verileri okuma
  Future<void> oturumoku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniciAdi = sp.getString("kullaniciadi") ?? "kullanici adi yok";
      spSifre = sp.getString("seviye") ?? "sifre yok";
    });

    // Bu sadece verilerin doğru şekilde yüklendiğini kontrol etmek için
    print("Kullanıcı Adı: $spKullaniciAdi, Şifre: $spSifre");
  }
  Future<void> verisil() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      sp.remove("kullaniciadi");
      sp.remove("seviye");
      sp.remove("ogrenilensayisi");
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Veriler Silindi"),
        duration: Duration(seconds: 2), // 2 saniye gösterilecek
      ),
    );


    // Bu sadece verilerin doğru şekilde yüklendiğini kontrol etmek için
    print("Kullanıcı Adı: $spKullaniciAdi, Şifre: $spSifre");
  }
  

  @override
  void initState() {
    super.initState();
    oturumoku(); // Ekran ilk açıldığında SharedPreferences'ı oku
    //goster();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Arkaplan rengini siyah yapıyoruz
      body: ListView(
        children: [
          ListTile(
            leading: SizedBox(height: 25, child: Image.asset("resimler/profil.png")),
            title: Row(
              children: [
                Text(spKullaniciAdi ?? "Yükleniyor...", style: TextStyle(color: Colors.black)), // Yazı rengini beyaz yapıyoruz
                Text("-", style: TextStyle(color: Colors.black)),
                Text(spSifre ?? "Yükleniyor...", style: TextStyle(color: Colors.black)),
              ],
            ),
            onTap: () {
              print("tıklandı");
            },
          ),
          ListTile(
            leading: Icon(Iconsax.setting_45, color: Colors.black), // Icon rengini beyaz yapıyoruz
            title: Text("Ayarlar", style: TextStyle(color: Colors.black)), // Yazı rengini beyaz yapıyoruz
            trailing: Icon(Icons.arrow_right, color: Colors.black), // Icon rengini beyaz yapıyoruz
            onTap: () {
              print("tıklandı");
            },
          ),
          ListTile(
            leading: Icon(Icons.sunny, color: Colors.black), // Icon rengini beyaz yapıyoruz
            title: Text("Açık Tema", style: TextStyle(color: Colors.black)), // Yazı rengini beyaz yapıyoruz
            trailing: Icon(Icons.arrow_right, color: Colors.black), // Icon rengini beyaz yapıyoruz
            onTap: () {
              print("tıklandı");
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.black), // Icon rengini beyaz yapıyoruz
            title: Text("Verileri Sil", style: TextStyle(color: Colors.black)), // Yazı rengini beyaz yapıyoruz
            trailing: Icon(Icons.arrow_right, color: Colors.black), // Icon rengini beyaz yapıyoruz
            onTap: () {
              verisil();
              print("tıklandı");
            },
          ),
        ],
      ),
    );
  }

}
