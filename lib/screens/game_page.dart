import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speezy/screens/downloadingpage.dart';
import 'package:speezy/utils/file_importers.dart';

class Oyun extends StatefulWidget {
  @override
  _OyunState createState() => _OyunState();
}

class _OyunState extends State<Oyun> {
  Future<void> addWords(String bolum_id) async {
    // Firestore koleksiyon referansı
    CollectionReference words = FirebaseFirestore.instance
        .collection('Bolumler')
        .doc(bolum_id)
        .collection("Kelimeler");

    // Yeni kelimeler listesi
    List<Map<String, dynamic>> wordsList = [
      {'ing': 'head', 'tr': 'kafa'},
      {'ing': 'hair', 'tr': 'saç'},
      {'ing': 'eyes', 'tr': 'gözler'},
      {'ing': 'ears', 'tr': 'kulaklar'},
      {'ing': 'nose', 'tr': 'burun'},
      {'ing': 'mouth', 'tr': 'ağız'},
      {'ing': 'teeth', 'tr': 'dişler'},
      {'ing': 'hand', 'tr': 'el'},
      {'ing': 'arm', 'tr': 'kol'},
      {'ing': 'leg', 'tr': 'bacak'},
      {'ing': 'foot', 'tr': 'ayak'},
      {'ing': 'back', 'tr': 'sırt'},
      {'ing': 'stomach', 'tr': 'mide'},
      {'ing': 'doctor', 'tr': 'doktor'},
      {'ing': 'nurse', 'tr': 'hemşire'},
      {'ing': 'hospital', 'tr': 'hastane'},
      {'ing': 'sick', 'tr': 'hasta'},
      {'ing': 'pain', 'tr': 'ağrı'},
      {'ing': 'medicine', 'tr': 'ilaç'},
      {'ing': 'fever', 'tr': 'ateş'},
    ];

    // Verileri Firestore'a ekle
    for (var word in wordsList) {
      try {
        await words.add(word);
        print("Word added: ${word['ing']}");
      } catch (e) {
        print("Failed to add word: $e");
      }
    }
  }





  Future<int> kelimesayisinigoster(int bolum_id)  {
    var sayi = Kelimelerdao().kelimeSayisiniGoster(bolum_id);

    return sayi;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addWords("w9k2j4GtzOWWgmHxURV2");


  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Bölümler",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Bolumler").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var bolumlistesi = snapshot.data!;

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, indeks) {
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color(0xFFE98A5C),  // Çerçevenin rengi
                    width: 2,  // Çerçevenin kalınlığı
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Text(
                      "${indeks + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    snapshot.data!.docs[indeks].data()["ad"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing:  Icon(Iconsax.arrow_circle_right4,
                      color: Colors.black
                  ),

                  onTap: () async {
                    if(await kelimesayisinigoster(snapshot.data!.docs[indeks].data()["bolum_id"],)==0){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => downloadingpage(snapshot.data!.docs[indeks].id, snapshot.data!.docs[indeks].data()["bolum_id"],)),
                      );
                    }else{
                      print("veriler zaten indirilmiş");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Oyna(snapshot.data!.docs[indeks].data()["bolum_id"])),
                      );
                      
                    }



                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
