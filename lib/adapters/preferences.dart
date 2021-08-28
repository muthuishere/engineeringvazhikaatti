import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{


  
  setInt(String key,int value) async {
    throw UnimplementedError("setInt");
  }
 Future<int?> getInt(String key) async{
    throw UnimplementedError("getInt");
  }

  setDouble(String key,double value) async{
    throw UnimplementedError("getDouble");
  }
  Future<double?> getDouble(String key) async{
    throw UnimplementedError("getDouble");
  }
  setString(String key,String value) async{
    throw UnimplementedError("setString");
  }
  Future<String?> getString(String key) async{
    throw UnimplementedError("getString");
  }
  void setObject<T>(String key,T value) async{
    throw UnimplementedError("setObject implemented in down stream");
  }

  Future<Map<String, dynamic>> getObjectAsJson(String key) async{
    throw UnimplementedError("getObjectAsJson");
  }



}