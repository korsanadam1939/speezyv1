import 'package:speezy/utils/file_importers.dart';
import 'package:path/path.dart';

class VeriTabaniY {
  static final String veritabaniadi = "kelimeler.db";

  static Future<Database> veritabanierisim() async {
    String veritabaniyolu = join(await getDatabasesPath(), veritabaniadi);

    if (await databaseExists(veritabaniyolu)) {
      print("veri tabanı zaten var");
    } else {
      ByteData data = await rootBundle.load("Veritabani/$veritabaniadi");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniyolu).writeAsBytes(bytes, flush: true);
      print("veritabanı kopyalandı");
    }

    return openDatabase(veritabaniyolu);
  }
}
