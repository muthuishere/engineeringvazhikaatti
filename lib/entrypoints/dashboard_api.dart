import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';


import '../stores/location_store.dart';
import '../stores/settings_store.dart';

class DashboardApi {

  late final SearchFilterStore _searchFilterStore;
  late final SettingsStore _settingsUpdater;
  late final LocationStore _locationUpdater;
  late final AppConfigStore _appConfigStore;
  String msg = "";


  // All event handlers to

  DashboardApi(

    this._searchFilterStore,
    this._settingsUpdater,
    this._locationUpdater,
    this._appConfigStore,
  );

}
