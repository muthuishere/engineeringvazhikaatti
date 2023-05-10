import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:engineeringvazhikaatti/entities/distance_option.dart';

import 'package:engineeringvazhikaatti/entities/models/response/college_detail.dart';

import '../entities/models/request/AppData.dart';
import '../entities/models/request/branch.dart';
import '../entities/models/request/college_with_branch.dart';

class AppConfigStore {
  late AppData appConfig;
   AppConfigStore(String contents){
     this.appConfig= AppData.fromJson(jsonDecode(contents));
   }
  List<Branch> getBranches() {
    return appConfig.branches;
  }
  List<CollegeWithBranch> getAllCollegeDetailWithBranches() {
    return appConfig.allcollegedata;
  }

  List<CollegeDetail> getAllCollegeDetails() {
    return appConfig.allcollegedata.map((e) => CollegeDetail.fromCollegeDetailWithBranches(e)).toList();
  }

  List<String> getDistricts() {
    return appConfig.districts;
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

 DistanceOption? getDistance(int num) {
  return  getDistances().firstWhereOrNull((element) => element.distance == num);
}

  Branch? getBranch(String code) {
    return getBranches().firstWhereOrNull((element) => element.code == code);
  }


  List<Branch> branchesFrom(String contents) {
    Iterable iterableContents = json.decode(contents);
    var items = iterableContents.map((content) => Branch.fromJson(content));
    return List<Branch>.from(items);
  }





}
