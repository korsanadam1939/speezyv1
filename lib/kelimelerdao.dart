import 'package:flutter/material.dart';
import 'package:speezy/Oyun.dart';
import 'package:speezy/bolumler.dart';
import 'package:speezy/kelime.dart';
import 'package:speezy/kelimelerdao.dart';
import 'package:speezy/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy/veritabaniyardimcisi.dart';


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
      var k = Kelime(satir["kelime_id"], satir["kelime_ing"], satir["kelime_ing"], b);


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
      var k = Kelime(satir["kelime_id"], satir["kelime_ing"], satir["kelime_tr"], b);

      return k;
    });



  }

  Future<void> sil(int id) async {
    var db = await VeriTabaniY.veritabanierisim();

    await db.rawDelete('DELETE FROM kelimeler WHERE kelime_id = ?',[id]);



  }





















}