import 'package:flutter/material.dart';
import 'package:speezy/Oyun.dart';
import 'package:speezy/bolumler.dart';
import 'package:speezy/kelimelerdao.dart';
import 'package:speezy/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Kelime{

  int kelime_id;
  String kelime;
  String anlam;
  Bolumler bolum;

  Kelime(this.kelime_id,this.kelime, this.anlam, this.bolum);


}