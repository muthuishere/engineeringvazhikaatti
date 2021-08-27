import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';
import 'package:injector/injector.dart';

class Entrypoints {


  init() {
    final injector = Injector.appInstance;

    var searchCollegesByCommunityAndCutoff =
        injector.get<SearchCollegesByCommunityAndCutoff>();
    var availableCollegesStore = injector.get<AvailableCollegesStore>();
    var _searchFilterStore = injector.get<SearchFilterStore>();
    var _settingsUpdater = injector.get<SettingsUpdater>();
    var _locationUpdater = injector.get<LocationUpdater>();


    injector.registerSingleton<DashboardApi>(() => DashboardApi(
        searchCollegesByCommunityAndCutoff, availableCollegesStore,_searchFilterStore,
        _settingsUpdater,_locationUpdater));
  }
}
