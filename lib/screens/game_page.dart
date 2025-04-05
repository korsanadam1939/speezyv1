import 'package:speezy/utils/file_importers.dart';

class Oyun extends StatelessWidget {
  Future<List<Bolumler>> Bolumlerigetir() async {
    var liste = await Kelimelerdao().bolumlerigetir();

    if (liste.isEmpty) {
      print("Veri yok");
    } else {
      for (Bolumler k in liste) {
        print("*********");
        print(k.bolumadi);
      }
    }
    return liste;
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
      body: FutureBuilder<List<Bolumler>>(
        future: Bolumlerigetir(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var bolumlistesi = snapshot.data!;

          return ListView.builder(
            itemCount: bolumlistesi.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, indeks) {
              var bolum = bolumlistesi[indeks];
              return Card(
                color: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.blue,  // Çerçevenin rengi
                    width: 2,  // Çerçevenin kalınlığı
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF000080),
                    child: Text(
                      "${indeks + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    bolum.bolumadi,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Oyna(bolum)),
                    );
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
