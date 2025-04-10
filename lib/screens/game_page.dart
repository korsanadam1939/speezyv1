import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speezy/utils/file_importers.dart';

class Oyun extends StatelessWidget {



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
                    snapshot.data!.docs[indeks].data()["ad"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    //Navigator.push(
                    //context;
                    //MaterialPageRoute(builder: (context) => Oyna(bolum)),
                    //);
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
