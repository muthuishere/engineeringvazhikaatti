import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';
import 'package:engineeringvazhikaatti/entities/filter.dart';
import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/providers/gps/greatcircle/great_circle_distance_calculator.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/college_details_store.dart';
import 'package:engineeringvazhikaatti/usecases/search_filter_updater.dart';


class TestDataGenerator {
  static AppConfigStore getAppConfigStore() {
    AppConfigStore appConfigStore = AppConfigStore();
    var branchContents = File('testassets/allbranches.json').readAsStringSync();
    appConfigStore.loadBranches(branchContents);
    var districtContents = File('testassets/districts.json').readAsStringSync();
    appConfigStore.loadDistricts(districtContents);
    return appConfigStore;
  }

  static CollegeDetailsStore getCollegeDetailsStore() {
    var contents =
        File('testassets/all_college_details.json').readAsStringSync();
    CollegeDetailsStore collegeDetailsStore = new CollegeDetailsStore();
    collegeDetailsStore.load(contents);
    return collegeDetailsStore;
  }

  static List<CollegeDetail> getCollegeDetails() {

    return getCollegeDetailsStore().collegeDetails;
  }
  static CollegeDetail getMockedCollegeDetail() {

    return getCollegeDetails()[0];
  }
  static DistanceCalculator getDistanceCalculator() {
    return GreatCircleDistanceCalculator();
  }

  static Filter getPreferences() {
    var updater = Filter();
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

}
