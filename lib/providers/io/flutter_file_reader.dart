import 'package:engineeringvazhikaatti/adapters/file_reader.dart';
import 'package:flutter/services.dart' show rootBundle;

class FlutterFileReader implements FileReader{

  Future<String> readFromAssetsFolder(String name) async{

      var key = 'assets/'+name;
      //print('reading $key');
      return await rootBundle.loadString(key);
  }
}