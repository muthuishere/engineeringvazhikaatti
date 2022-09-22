import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/adapters/app_preferences.dart';
import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';

import 'package:engineeringvazhikaatti/entities/models/request/branch_with_cutoff.dart';
import 'package:engineeringvazhikaatti/entities/models/request/college_with_branch.dart';
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/entities/models/response/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entities/search_filter.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/providers/gps/greatcircle/great_circle_distance_calculator.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/location_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/stores/settings_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TestDataGenerator {


  static AppConfigStore getMockedAppConfigStore() {
    return appConfigStoreFrom('testassets/mockdata.json');
  }

  static CollegeWithBranch getAnnaUniversityCollege() {

    var allCollegeDetailWithBranches = getMockedAppConfigStore().getAllCollegeDetailWithBranches();
    print(allCollegeDetailWithBranches.length);
    return allCollegeDetailWithBranches.firstWhere((element) => element.code == 1);
  }

  static BranchWithCutoff getCSInAnnaUniversity() {

    return getAnnaUniversityCollege().branches.firstWhere((element) => element.code == 'CS');
  }


  static AppConfigStore getFullAppConfigStore() {
    return appConfigStoreFrom('testassets/finaldelivery.json');

  }

  static AppConfigStore appConfigStoreFrom(String path) {
    var contents = File(path).readAsStringSync();
    return AppConfigStore(contents);
  }

  static List<CollegeDetail> getFullCollegeDetails() {

    return getFullAppConfigStore().getAllCollegeDetails();
  }
  static CollegeDetail getMockedCollegeDetail() {

    return getFullCollegeDetails()[0];
  }
  static DistanceCalculator getDistanceCalculator() {
    return GreatCircleDistanceCalculator();
  }

  static SearchFilter getPreferences() {
    var updater = SearchFilter();
    updater.setBranchCodes(["CS", "IT"]);
    updater.setDistricts(["Chennai", "Chengalpattu", "Thiruvallur"]);

    return updater;
  }
  List<AvailableCollege> getMockedAvailableCollegeDetails() {
    String contents =
    File('testassets/available_colleges.json').readAsStringSync();
    Iterable iterableContents = json.decode(contents);
    var items =
    iterableContents.map((content) => AvailableCollege.fromJson(content));
    return List<AvailableCollege>.from(items);
  }

  static getSearchFilterStore() {
    var searchFilterStore = SearchFilterStore();
    return searchFilterStore;
  }

  static getSearchFilterStoreWith(SearchFilter searchFilter) {
    var searchFilterStore = SearchFilterStore();
    searchFilterStore.updateWith(searchFilter);
    return searchFilterStore;
  }


  static SearchFilter getSearchFilterWithDistrictChennai() {
    var searchFilter = SearchFilter();
    searchFilter.setDistricts(["Chennai"]);
    searchFilter.searchByDistricts = true;
    return searchFilter;
  }

  static SearchFilter getSearchFilterWithin150KmsAroundChennai() {
    var searchFilter = SearchFilter();
    searchFilter.setDistanceInKms(150);
    searchFilter.searchByDistricts = false;
    return searchFilter;
  }
  static SearchFilter getSearchFilterWithDistanceNull() {
    var searchFilter = SearchFilter();
    searchFilter.setDistanceInKms(0);
    searchFilter.searchByDistricts = false;
    return searchFilter;
  }
  static SearchFilter getSearchFilterWithDistance200Kms() {
    //searchFilter.searchByDistricts{message: Searching on 1branches on 1 districts, distanceInKms: 50, year: 2021, searchByDistricts: false, branchCodes: CS, districts: Chennai

    var searchFilter = SearchFilter();
    searchFilter.setDistanceInKms(200);
    searchFilter.searchByDistricts = false;

    searchFilter.setBranchCodes(["CS"]);
    searchFilter.setDistricts(["Chennai"]);

    return searchFilter;
  }
  static SearchFilter getSearchFilterWithin150KmsAroundChennaiAndCsBranch() {
    var searchFilter = SearchFilter();
    searchFilter.setDistanceInKms(150);
    searchFilter.searchByDistricts = false;
    searchFilter.setBranchCodes(["CS"]);
    return searchFilter;
  }


  static getSearchFilterWithDistrictsNull() {
    var searchFilter = SearchFilter();
    searchFilter.setDistricts(null);
    searchFilter.searchByDistricts = true;
    return searchFilter;

  }
  static LocationStore getLocationStoreForVirugambakkam() {
    return locationForCoordinates(13.0827, 80.2707);
  }
  static LocationStore getLocationStoreForMadurai() {
    return locationForCoordinates(9.925201, 78.119774);
  }
  static LocationStore getLocationStoreForTuticorin() {
    return locationForCoordinates(8.764166, 78.134834);
  }

  static LocationStore locationForCoordinates(double lat, double lon) {
      var locationStore = LocationStore();

    locationStore.setLocation(lat, lon);
    return locationStore;
  }

  static Future<SettingsStore> getSettingsStore () async {
  var settings=  Settings(
        physics: 70.0,
        chemistry: 70.0,
        maths: 70.0,
        communityGroup: CommunityGroup.BC);

  return await getSettingsStoreWith(settings);


  }

  static Future<SettingsStore> getSettingsStoreWith(Settings settings) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    var appPreferences = AppPreferences(prefs);
      return SettingsStore(settings, appPreferences);
  }




}
