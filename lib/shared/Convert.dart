import 'dart:convert';
import 'dart:ffi';

class Convert{
  static double? toDouble(dynamic value){
    if(value is double){
      return value;
    }
    if(value is int){
      return value.roundToDouble();
    }
    if(value is String){
      if(value == "")
        return null;
      else
        return double.parse(value);
    }

  }
  static int? toInt(dynamic value){
    if(value is int){
      return value;
    }
    if(value is String){
      if(value == "")
        return null;
      else
        return int.parse(value);
    }

  }


 static List<String> asListofStrings(String contents) {
    Iterable iterableContents = json.decode(contents);
    return List<String>.from(iterableContents);
  }

 static List<int> asListOfIntegers(String contents) {
    Iterable iterableContents = json.decode(contents);
    return List<int>.from(iterableContents);
  }
}