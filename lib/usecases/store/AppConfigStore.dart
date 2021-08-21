import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/AppConfig.dart';
import 'package:engineeringvazhikaatti/entities/models/EnggBranch.dart';
import 'package:engineeringvazhikaatti/shared/Convert.dart';

class AppConfigStore {
  var appConfig = AppConfig();

  List<EnggBranch> getBranches() {
    return appConfig.branches;
  }

  List<String> getDistricts() {
    return appConfig.districts;
  }

  List<int> getPincodes() {
    return appConfig.pincodes;
  }

  List<EnggBranch> branchesFrom(String contents) {
    Iterable iterableContents = json.decode(contents);
    var items = iterableContents.map((content) => EnggBranch.fromJson(content));
    return List<EnggBranch>.from(items);
  }


  void loadBranches(String contents) {
    appConfig.branches = branchesFrom(contents);
  }

  void loadDistricts(String contents) {
    appConfig.districts =Convert.asListofStrings(contents);
  }

  void loadPincodes(String contents) {
    appConfig.pincodes=Convert.asListOfIntegers(contents);;
  }

}
