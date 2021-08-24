import 'dart:io';

import 'package:engineeringvazhikaatti/entities/Filter.dart';
import 'package:engineeringvazhikaatti/usecases/PreferencesUpdater.dart';
import 'package:engineeringvazhikaatti/usecases/store/AppConfigStore.dart';
import 'package:engineeringvazhikaatti/usecases/store/CollegeDetailsStore.dart';

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

  static Filter getPreferences() {
    var updater = Filter();
    updater.setBranchCodes(["CS", "IT"]);
    updater.setDistricts(["Chennai", "Chengalpattu", "Thiruvallur"]);

    return updater;
  }
}
