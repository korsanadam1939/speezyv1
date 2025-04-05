import 'package:speezy/utils/file_importers.dart';


class Kelimelerdao{

  //SELECT * FROM filmler,kategoriler,yonetmenler WHERE filmler.kategori_id = kategoriler.kategori_id AND filmler.yonetmen_id = yonetmenler.yonetmen_id





  Future<List<Kelime>> tumkelimeler() async {
    var db = await VeriTabaniY.veritabanierisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler,bolumler WHERE kelimeler.bolum_id= bolumler.bolum_id");

    if (maps.isEmpty) {
      print("Veritabanı boş!");
    } else {
      print("Veritabanında ${maps.length} kayıt var.");
    }

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      var b =Bolumler(satir["bolum_ad"], satir["bolum_id"]);
      var k = Kelime(satir["kelime_id"], satir["kelime_ing"], satir["kelime_ing"],b,satir["kaydedildimi"]);


      return k;
    });
  }

  Future<int> kelimeSayisiniGoster() async {
    var db = await VeriTabaniY.veritabanierisim();
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT COUNT(*) as count FROM kelimeler");


    int sayi = result.first["count"];
    return sayi;
  }


  Future<List<Bolumler>> bolumlerigetir() async {
    var db = await VeriTabaniY.veritabanierisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM bolumler");

    if (maps.isEmpty) {
      print("Veritabanı boş!");
    } else {
      print("Veritabanında ${maps.length} kayıt var.");
    }

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      var b =Bolumler(satir["bolum_ad"], satir["bolum_id"]);



      return b;
    });
  }

  Future<List<Kelime>> rastgelekelime(int bolumid) async {
    var db = await VeriTabaniY.veritabanierisim();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kelimeler WHERE bolum_id = ? ORDER BY RANDOM() LIMIT 1;",
        [bolumid] // SQL Injection riskine karşı parametreli sorgu
    );

    if (maps.isEmpty) {
      print("Veritabanı boş!");
      return []; // Boş liste döndür
    } else {
      print("Veritabanında ${maps.length} kayıt var.");
    }

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      var b = Bolumler(satir["bolum_ad"] ?? "Bilinmeyen Bölüm", satir["bolum_id"]);
      var k = Kelime(satir["kelime_id"], satir["kelime_ing"], satir["kelime_tr"],b,satir["kaydedildimi"]);

      return k;
    });



  }

  Future<void> sil(int id) async {
    var db = await VeriTabaniY.veritabanierisim();

    await db.rawDelete('DELETE FROM kelimeler WHERE kelime_id = ?',[id]);



  }

  Future<void> kaydedilenekle(Kelime kelime) async {
    var db = await VeriTabaniY.veritabanierisim();
    var bilgiler = <String, dynamic>{
      "kelime_tr": kelime.anlam,
      "kelime_ing": kelime.kelime,
      "kelime_id": kelime.kelime_id,
    };

    await db.insert("kaydedilenkelimeler", bilgiler);
    print("${kelime.kelime} eklendi");
  }

  Future<void> kaydedilenguncelle(int kelime_id) async {
    var db = await VeriTabaniY.veritabanierisim();
    var bilgiler = <String, dynamic>{
      "kaydedildimi": 1,

    };

    await db.update("kelimeler",bilgiler,where: "kelime_id=?",whereArgs: [kelime_id]);
    print(bilgiler);
  }






















}