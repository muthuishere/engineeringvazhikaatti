import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/distance_option.dart';
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


  List<DistanceOption> getDistances() {
    return [
      DistanceOption("Less than 50 Kms",50),
      DistanceOption("Less than 100 Kms",100),
      DistanceOption("Less than 200 Kms",200),
      DistanceOption("Less than 500 Kms",500),
      DistanceOption("Across Tamilnadu",2500),
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

}
