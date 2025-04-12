import 'package:speezy/data/word_model.dart';

class Savedwords {
  int kaydedilenkelime_id;
  Kelime kelime;
  String kelime_tr;
  String kelime_ing;

  Savedwords(
      this.kaydedilenkelime_id, this.kelime, this.kelime_tr, this.kelime_ing);
}