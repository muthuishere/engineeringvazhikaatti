import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/shared/Validators.dart';

class SettingsUpdater {
  final Preferences preferences;
  late Settings settings;

  SettingsUpdater(this.preferences) {
    preferences.getObjectAsJson("settings").then((value) {
      settings =
          isEmptyMap(value) ? defaultSettings() : Settings.fromJson(value);
    }).catchError((mg) {

      settings = defaultSettings();
      return null;
    });
  }

  defaultSettings() {

    return Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);
  }


  Settings getSettings() {
    return settings;
  }

  void update(double physics, double chemistry, double maths,
      CommunityGroup communityGroup) {


    settings.set(physics, chemistry, maths, communityGroup);
    preferences.setObject<Settings>("settings", settings);

  }
  bool hasAllData() {
    return null != settings && null != settings.communityGroup && settings.getCutOff() > 0;
  }

}
