import 'package:engineeringvazhikaatti/adapters/file_reader.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/location_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:injector/injector.dart';

import '../../adapters/app_preferences.dart';
import '../../stores/available_branch_detail_store.dart';
import '../../stores/settings_store.dart';

class Stores {
  Future<AppConfigStore> getAppConfigStore() async {
    final injector = Injector.appInstance;
    var fileReader = injector.get<FileReader>();
    var contents = await fileReader.readFromAssetsFolder("finaldelivery.json");
    var appConfigStore = AppConfigStore(contents);
    return appConfigStore;
  }


  Future<SettingsStore> getSettingsStore() async {
    final injector = Injector.appInstance;
    var preferences = injector.get<AppPreferences>();

    var existingSettings = await preferences.getSettings();
    return SettingsStore(existingSettings,preferences);
  }
  LocationStore getLocationStore() {
    final injector = Injector.appInstance;
   var preferences = injector.get<AppPreferences>();
    return LocationStore();
  }

  init() async {
    final injector = Injector.appInstance;
    var appConfigStore = await getAppConfigStore();
    var searchFilterStore = SearchFilterStore();
    var preferences  = injector.get<AppPreferences>();

    var settingsStore = await getSettingsStore();
    var locationStore = getLocationStore();
    injector.registerSingleton<LocationStore>(() => locationStore);
    injector.registerSingleton<SettingsStore>(() => settingsStore);

    injector.registerSingleton<AvailableBranchDetailStore>(() => AvailableBranchDetailStore( settingsStore:settingsStore,   locationStore:locationStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore));
    injector.registerSingleton<AppConfigStore>(() => appConfigStore);


    injector.registerSingleton<SearchFilterStore>(() => searchFilterStore);
  }
}
