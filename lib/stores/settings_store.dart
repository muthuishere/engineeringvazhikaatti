import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/entities/cutoffstatus.dart';
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/shared/Validators.dart';
import 'package:rxdart/rxdart.dart';

import '../adapters/app_preferences.dart';

class SettingsStore {
  final AppPreferences preferences;
  // late Settings settings;
  BehaviorSubject<Settings> _settingsObserver =
  new BehaviorSubject<Settings>();


  SettingsStore(Settings existingSettings,this.preferences) {
     _settingsObserver.sink.add(existingSettings);
  }



  Settings getSettings() {
    return _settingsObserver.value;
  }
  Stream<Settings>  listener(){
    return _settingsObserver.stream;
  }

  void update(double physics, double chemistry, double maths,
      CommunityGroup communityGroup) {

    Settings settings = Settings(
        physics: physics,
        chemistry:chemistry,
        maths: maths,
        communityGroup: communityGroup);
    _settingsObserver.add(settings);
    preferences.saveSettings(settings);

  }
  bool hasAllData() {
    return null != getSettings() ;
  }

}
