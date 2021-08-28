import 'dart:convert';

import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterPreferences implements Preferences{


  Future<SharedPreferences> getPreferencesInstance() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs;
  }
  
  setInt(String key,int value) async {
    var prefs = await getPreferencesInstance();
    await prefs.setInt(key, value);
  }
  getInt(String key) async{
    var prefs = await getPreferencesInstance();
    return prefs.getInt(key);
  }

  setDouble(String key,double value) async{
    var prefs = await getPreferencesInstance();
    await prefs.setDouble(key, value);
  }
  getDouble(String key) async{
    var prefs = await getPreferencesInstance();
    return prefs.getDouble(key);
  }
  setString(String key,String value) async{
    var prefs = await getPreferencesInstance();
    await prefs.setString(key, value);
  }
  getString(String key) async{
    var prefs = await getPreferencesInstance();
    return prefs.getString(key);
  }
  setObject<T>(String key,T value) async{
    var prefs = await getPreferencesInstance();
    String contents = jsonEncode(value);
    await prefs.setString(key, contents);
  }

 getObjectAsJson(String key) async{
    var prefs = await getPreferencesInstance();

    String? contents = (prefs.getString(key) ?? null) ;
    Map<String, dynamic> jsonObject = {};

    if(null != contents){
      try {
        jsonObject = jsonDecode(contents);
      } on FormatException catch (e) {
        print('The provided string is not valid JSON');
      }
    }
    return jsonObject;

  }



}