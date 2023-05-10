import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../entities/models/request/community_group.dart';
import '../entities/settings.dart';

class AppPreferences{
  final SharedPreferences _sharedPreference;

  AppPreferences(this._sharedPreference);



  Future<bool> saveSettings(Settings value) async {
    return _sharedPreference.setString("settings", jsonEncode(value));
  }
  Future<Settings> getSettings() async {
    var raw = _sharedPreference.getString("settings") ?? "";

    if(raw == ""){
      return defaultSettings();
    }else{
      return Settings.fromJson(jsonDecode(raw));
    }
  }

  defaultSettings() {

    return Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);
  }

}