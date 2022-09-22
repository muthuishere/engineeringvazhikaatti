import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';

import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';

import 'package:injector/injector.dart';

import '../../stores/location_store.dart';
import '../../stores/settings_store.dart';

class Entrypoints {


  init() {
    final injector = Injector.appInstance;


    var _searchFilterStore = injector.get<SearchFilterStore>();
    var _settingsUpdater = injector.get<SettingsStore>();
    var _locationUpdater = injector.get<LocationStore>();
    var _appConfigStore = injector.get<AppConfigStore>();




  }
}
