
import '../utils/file_importers.dart';

class Oyna extends StatefulWidget {
  int bolum_id;


  Oyna(this.bolum_id);

  @override
  State<Oyna> createState() => _OynaState();
}

class _OynaState extends State<Oyna> {

  late Kelime word;
  String? kelime ;
  String? kelimeanlam;
  int? kelimeid=1;
  late bool durum=true;
  late int ogrenilenkelimesayisi=0 ;
  late bool isButtonEnabled = true;
  bool icondurum =false;
  late int kaydedildimi;


  Future<void> goster() async {
    var liste = await Kelimelerdao().rastgelekelime(widget.bolum_id);

    if (liste.isNotEmpty && liste[0].kelime != null) {
      kaydedildimi =liste[0].kaydedildimi;
      if (kaydedildimi ==0){
        icondurum = false;
      }
      else{
        icondurum =true;
      }
      setState(() {
        word = liste[0];
        kelime = liste[0].kelime!;
        kelimeanlam = liste[0].anlam;
        kelimeid = liste[0].kelime_id;





      });
    } else {
      setState(() {
        kelime = "Kelimeler bitti!";
        kelimeanlam = "Kelimeler bitti !";
        setState(() {
          isButtonEnabled = false;
        });

      });
    }
  }


  Future<void> sil(int id) async {
    if(id != 30){
      await Kelimelerdao().sil(id);
      print("$id li kelime silindi");


    }


  }
  Future<void> kaydedilenekle(Kelime kelime) async{
    await Kelimelerdao().kaydedilenekle(kelime);
    kaydedilendurumguncelle(kelime.kelime_id);



  }

  Future<void> kaydedilendurumguncelle(int kelime_id) async{
    await Kelimelerdao().kaydedilenguncelle(kelime_id);



  }


  Future<void> ogrenilenkelimelerioku() async {
    var sp = await SharedPreferences.getInstance();

    ogrenilenkelimesayisi =await sp.getInt("ogrenilensayisi") ?? 0;



  }

  Future<void> ogrenilenkelimelerihesapla() async {
    var sp = await SharedPreferences.getInstance();

    ogrenilenkelimesayisi++;
    await sp.setInt("ogrenilensayisi", ogrenilenkelimesayisi);



  }



  @override
  void initState() {
    super.initState();
    print(ogrenilenkelimesayisi);
    goster();
    ogrenilenkelimelerioku().then((_) {
      setState(() {
        print(ogrenilenkelimesayisi); // Bu satır ogrenilenkelimesayisi güncellendikten sonra çalışacak.
      });
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Oyna",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: (){
                setState(() {

                  durum=false;
                });




              },

              child: Container(
                height: 200,
                width: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: durum
                        ? [Colors.blue,Color(0xFF000080)]
                        : [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Ortadaki yazı
                    Center(
                      child: Text(
                        durum ? (kelime ?? 'yükleniyor') : (kelimeanlam ?? 'yükleniyor'),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Sağ üst köşedeki ikon
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(icondurum ? Iconsax.archive_add1 : Iconsax.archive_add, color: Colors.white),
                        onPressed: () {
                          if(icondurum){
                            print("bu kelime zaten eklenmiş ");


                          }
                          else{
                            kaydedilenekle(word);
                            setState(() {
                              icondurum = true;
                            });

                          }

                        },
                      ),
                    ),
                  ],
                ),
              ),

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                      if (durum == false) {

                        setState(() {
                          durum = true;
                        });
                        ogrenilenkelimelerihesapla();

                        sil(kelimeid ?? 30);
                        goster();

                        print(ogrenilenkelimesayisi);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Dostum önce kelimenin anlamına bak 😅'),
                            duration: Duration(seconds: 2), // Mesajın ne kadar süreyle görüneceği
                          ),
                        );
                      }
                    }
                        : null, // Butonu devre dışı bırakır
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF000080),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10 ,
                      shadowColor:  Colors.purple,
                    ),
                    child: Text(
                      "Biliyorum",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if(durum==false){
                        goster();
                        setState(() {
                          durum = true;
                        });


                      }


                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF000080),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      shadowColor: Colors.deepPurple.withOpacity(0.5),
                    ),
                    child: Text(
                      "Tekrar Göster",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
