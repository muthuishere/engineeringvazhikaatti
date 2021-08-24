import 'dart:convert';

import 'dart:io';

class JsonConvert {
  static void saveAsFile<T>(String filename, T object) {
    String contents = jsonEncode(object);
    var file = new File(filename);
    file.writeAsStringSync(contents, mode: FileMode.write);
    print("Saved as " + filename);
  }
}
