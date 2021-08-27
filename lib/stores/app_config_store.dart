import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/DistanceConfig.dart';
import 'package:engineeringvazhikaatti/entities/app_config.dart';
import 'package:engineeringvazhikaatti/entities/models/engg_branch.dart';
import 'package:engineeringvazhikaatti/shared/convert.dart';

class AppConfigStore {
  var appConfig = AppConfig();

  List<EnggBranch> getBranches() {
    return appConfig.branches;
  }

  List<String> getDistricts() {
    return appConfig.districts;
  }

  List<String> getPincodes() {
    return appConfig.pincodes;
  }


  List<DistanceConfig> getDistances() {
    return [
      DistanceConfig("Less than 50 Kms",50),
      DistanceConfig("Less than 100 Kms",100),
      DistanceConfig("Less than 200 Kms",200),
      DistanceConfig("Less than 500 Kms",500),
      DistanceConfig("Across Tamilnadu",2500),
    ];
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
    appConfig.pincodes=Convert.asListofStrings(contents);;
  }

  void loadDistrictsFromFuture(Future<String> districts) {
    districts.then((value) => loadDistricts(value));
  }

  void loadPincodesFromFuture(Future<String> pincodes) {
    pincodes.then((value) => loadPincodes(value));
  }

  void loadBranchesFromFuture(Future<String> branches) {
    branches.then((value) => loadBranches(value));
  }

}
