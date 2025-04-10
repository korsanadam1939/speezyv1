import '../utils/file_importers.dart';

class Oyna extends StatefulWidget {
  @override
  State<Oyna> createState() => _OynaState();
}

class _OynaState extends State<Oyna> {
  var durum = true;

  @override
  void initState() {
    super.initState(); // hata ne
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
              onTap: () {
                setState(() {
                  // durum değişebilir
                });
              },
              child: Container(
                height: 200,
                width: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Color(0xFF000080)],
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
                    Center(
                      child: Text(
                        "kelime",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(Iconsax.archive_add1),
                        onPressed: () {
                          // işlem
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
                    onPressed: () {
                      // Biliyorum butonu
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF000080),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      shadowColor: Colors.purple,
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
                      // Tekrar göster butonu
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
