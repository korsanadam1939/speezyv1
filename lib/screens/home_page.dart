

import '../utils/file_importers.dart';

class HomeScreen extends StatefulWidget {
  final double ekranyuksekligi;
  final Function(int) onTabChange;


  const HomeScreen({Key? key, required this.ekranyuksekligi, required this.onTabChange}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int ogrenilenkelimesayisi = 0;
  String? spKullaniciAdi;
  String? spSifre;
  double _progress = 0.0;
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



  @override
  void initState() {
    super.initState();
    //_startProgress();
    ogrenilenkelimelerioku();
    oturumoku();
  }




  Future<void> ogrenilenkelimelerioku() async {
    var sp = await SharedPreferences.getInstance();



    setState(() {
      ogrenilenkelimesayisi = sp.getInt("ogrenilensayisi") ?? 0;
      _progress = ogrenilenkelimesayisi/100;
    });





  }



  void _startProgress() {
    setState(() {

    });
  }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true, // Başlık ortalanır
        title: const Text(
          "Speezy",
          style: TextStyle(color: Color(0xFF000080), fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.notification_bing, color: Colors.black),
          onPressed: () {},
        ),
        ),


        body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: widget.ekranyuksekligi / 130, bottom: widget.ekranyuksekligi / 40),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
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
              padding: EdgeInsets.only(left: 10, right: 10, bottom: widget.ekranyuksekligi / 45),
              child: Container(
                height: widget.ekranyuksekligi / 7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Color(0xFF000080)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Merhaba $spKullaniciAdi",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          ),
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
                        Text(
                          "$ogrenilenkelimesayisi/100 Kelime öğrenildi",
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "Eğitimler",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.only(bottom: widget.ekranyuksekligi / 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(4, (index) {
                    List<String> levels = ["A1", "A2", "B1", "B2"];
                    return Padding(
                      padding: EdgeInsets.only(right: widget.ekranyuksekligi / 100, left: 10, bottom: 10),
                      child: Container(
                        height: widget.ekranyuksekligi / 7.5,
                        width: widget.ekranyuksekligi / 5,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.2),
                              blurRadius: 3,
                              spreadRadius: 0,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [Color(0xFF000080), Colors.blue],
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
      ),
    );
  }

}
