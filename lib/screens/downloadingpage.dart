import '../utils/file_importers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class downloadingpage extends StatefulWidget {
  String bolumId;
  int bolum_idsayi;
  downloadingpage(this.bolumId,this.bolum_idsayi);


  @override
  State<downloadingpage> createState() => _downloadingpageState();
}

class _downloadingpageState extends State<downloadingpage> {



  var metin = "";

  Future<void> ekle(String tr,String ing) async{

    await Kelimelerdao().kelimeekle(tr, ing,widget.bolum_idsayi,0);



  }

  Future<void> goster() async {

    var liste = await Kelimelerdao().tumkelimeler();

    for(Kelime k in liste){
      print("kelime adı : ${k.kelime}");



    }


  }





  Future<void> addWords(String bolum_id) async {
    // Doğrudan koleksiyon referansını alıyoruz
    CollectionReference words = FirebaseFirestore.instance
        .collection('Bolumler')
        .doc(bolum_id) // Belge referansı
        .collection("Kelimeler"); // İç koleksiyon referansı

    // Kelimeler listesi
    List<Map<String, dynamic>> wordsList = [
      {'ing': 'name', 'tr': 'isim'},
      {'ing': 'surname', 'tr': 'soyad'},
      {'ing': 'age', 'tr': 'yaş'},
      {'ing': 'address', 'tr': 'adres'},
      {'ing': 'phone', 'tr': 'telefon'},
      {'ing': 'family', 'tr': 'aile'},
      {'ing': 'mother', 'tr': 'anne'},
      {'ing': 'father', 'tr': 'baba'},
      {'ing': 'sister', 'tr': 'kız kardeş'},
      {'ing': 'brother', 'tr': 'erkek kardeş'},
      {'ing': 'husband', 'tr': 'koca'},
      {'ing': 'wife', 'tr': 'eş'},
      {'ing': 'son', 'tr': 'oğul'},
      {'ing': 'daughter', 'tr': 'kız evlat'},
      {'ing': 'child', 'tr': 'çocuk'},
      {'ing': 'parents', 'tr': 'ebeveynler'},
      {'ing': 'friend', 'tr': 'arkadaş'},
      {'ing': 'baby', 'tr': 'bebek'},
      {'ing': 'uncle', 'tr': 'amca/dayı'},
      {'ing': 'aunt', 'tr': 'teyze/hala'},
      {'ing': 'cousin', 'tr': 'kuzen'},
      {'ing': 'grandmother', 'tr': 'büyükanne'},
      {'ing': 'grandfather', 'tr': 'büyükbaba'},
      {'ing': 'nephew', 'tr': 'erkek yeğen'},
      {'ing': 'niece', 'tr': 'kız yeğen'},
    ];

    // Verileri Firestore'a ekleyin
    for (var word in wordsList) {
      try {
        await words.add(word); // Kelimeleri koleksiyona ekliyoruz
        print("Word added: ${word['ing']}");
        await ekle(word["tr"], word["ing"],);
      } catch (e) {
        print("Failed to add word: $e");
      }
    }
  }


  Future<void> fetchKelimeler(String bolum_id) async {
    try {

      var snapshot = await FirebaseFirestore.instance.collection('Bolumler').doc(bolum_id).collection("Kelimeler").get();




      for (var doc in snapshot.docs) {
        print('Kelime: ${doc['ing']}, Anlam: ${doc['tr']}');
        print("deneme");
        await ekle(doc["tr"], doc["ing"]);
        setState(() {
          metin=doc["ing"];
        });
      }
      metin ="yüklendi";
      Navigator.pop(context);
      print("deneme2");
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    fetchKelimeler(widget.bolumId);
    //goster();

    //addWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Yükleniyor'),backgroundColor: Colors.white,),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: CircularProgressIndicator(color: Colors.deepOrange,           // Dönen halkanın rengi
                strokeWidth: 6.0,    ),
            ),


            Text("$metin Eklendi...",style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
