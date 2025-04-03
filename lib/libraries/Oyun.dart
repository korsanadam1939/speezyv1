
import '../utils/file_importers.dart';

class Oyna extends StatefulWidget {
  final Bolumler bolum;

  Oyna(this.bolum);

  @override
  State<Oyna> createState() => _OynaState();
}

class _OynaState extends State<Oyna> {

  String? kelime ;
  String? kelimeanlam;
  int? kelimeid=1;
  late bool durum=true;
  late int ogrenilenkelimesayisi=0 ;


  Future<void> goster() async {
    var liste = await Kelimelerdao().rastgelekelime(widget.bolum.bolumid);

    if (liste.isNotEmpty && liste[0].kelime != null) {
      setState(() {
        kelime = liste[0].kelime!;
        kelimeanlam = liste[0].anlam;
        kelimeid = liste[0].kelime_id;
      });
    } else {
      setState(() {
        kelime = "Kelime bulunamadı!";
      });
    }
  }


  Future<void> sil(int id) async {

    await Kelimelerdao().sil(id);


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
        backgroundColor: Color(0xFF121212),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Oyna",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Color(0xFF121212),
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
                    colors:durum ? [Colors.deepPurple, Colors.black] : [Colors.purple, Colors.black],
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
                child: Center(
                  child: Text(durum ? (kelime ?? 'yükleniyor') : (kelimeanlam ?? 'yükleniyor'),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
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
                    onPressed: () {
                      if(durum==false){
                        goster();
                        setState(() {
                          durum = true;
                        });
                        ogrenilenkelimelerihesapla();

                        sil(kelimeid ?? 1);
                        print(ogrenilenkelimesayisi);

                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Dostum önce kelimenin anlamına bak 😅'),
                            duration: Duration(seconds: 2), // Mesajın ne kadar süreyle görüneceği
                          ),
                        );
                      }


                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      shadowColor: Colors.deepPurple.withOpacity(0.5),
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
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.black,
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
