import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';
import 'package:engineeringvazhikaatti/adapters/file_reader.dart';
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/providers/gps/greatcircle/great_circle_distance_calculator.dart';
import 'package:engineeringvazhikaatti/providers/io/flutter_file_reader.dart';
import 'package:engineeringvazhikaatti/stores/college_details_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_filter_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';
import 'package:engineeringvazhikaatti/usecases/sort_colleges.dart';

import 'package:injector/injector.dart';

class Usecases {
  init() {
    final injector = Injector.appInstance;

    var searchFilterStore = injector.get<SearchFilterStore>();


    injector
        .registerSingleton<SearchFilterUpdater>(() => SearchFilterUpdater(searchFilterStore));
    injector.registerSingleton<SettingsUpdater>(() => getSettingsUpdater());
    injector.registerSingleton<LocationUpdater>(() => getLocationUpdater());


    injector.registerSingleton<SearchColleges>(() => getSearchColleges());
    injector.registerSingleton<SortColleges>(() => getSortColleges());
    injector.registerSingleton<SearchCollegesByCommunityAndCutoff>(
        () => getSearchCollegesByCommunityAndCutoff());
  }

  SearchColleges getSearchColleges() {
    final injector = Injector.appInstance;
    var collegeDetailsStore = injector.get<CollegeDetailsStore>();
    var distanceCalculator = injector.get<DistanceCalculator>();

    var searchColleges =
        SearchColleges(collegeDetailsStore, distanceCalculator);

    return searchColleges;
  }

  SettingsUpdater getSettingsUpdater() {
    final injector = Injector.appInstance;

    var preferences = injector.get<Preferences>();

    var settingsUpdater = SettingsUpdater(preferences);

    return settingsUpdater;
  }

  LocationUpdater getLocationUpdater() {
    final injector = Injector.appInstance;

    var preferences = injector.get<Preferences>();

    var settingsUpdater = LocationUpdater(preferences);

    return settingsUpdater;
  }

  SortColleges getSortColleges() {
    final injector = Injector.appInstance;

    var distanceCalculator = injector.get<DistanceCalculator>();

    var sortColleges = SortColleges(distanceCalculator);

    return sortColleges;
  }

  SearchCollegesByCommunityAndCutoff getSearchCollegesByCommunityAndCutoff() {
    final injector = Injector.appInstance;
    var collegeDetailsStore = injector.get<CollegeDetailsStore>();
    var distanceCalculator = injector.get<DistanceCalculator>();

    var searchColleges = SearchCollegesByCommunityAndCutoff(
        collegeDetailsStore, distanceCalculator);

    return searchColleges;
  }
}
