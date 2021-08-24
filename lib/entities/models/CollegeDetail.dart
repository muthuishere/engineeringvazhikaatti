import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/YearDetail.dart';
import '../Filter.dart';
import 'package:engineeringvazhikaatti/shared/Search.dart';

import 'CollegeLocation.dart';
import 'EnggBranch.dart';

class CollegeDetail {
  String? address;
  List<EnggBranch>? branches;
  late List<String?> availableBranchCodes;

  String? district;
  int? id;
  CollegeLocation? location;
  String? name;
  String? pincode;
  String? rank;
  String? state;

  CollegeDetail(
      {this.address,
      this.branches,
      this.district,
      this.id,
      this.location,
      required this.name,
      this.pincode,
      this.rank,
      this.state}) {
    availableBranchCodes = branches!.map((e) => e.code).toList();
  }

  factory CollegeDetail.fromJson(Map<String, dynamic> json) {
    return CollegeDetail(
      address: json['address'],
      branches: json['branches'] != null
          ? (json['branches'] as List)
              .map((i) => EnggBranch.fromJson(i))
              .toList()
          : null,
      district: json['district'],
      id: json['id'],
      location: json['location'] != null
          ? CollegeLocation.fromJson(json['location'])
          : null,
      name: json['name'],
      pincode: json['pincode'],
      rank: json['rank'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['district'] = this.district;
    data['id'] = this.id;
    data['name'] = this.name;
    data['pincode'] = this.pincode;
    data['rank'] = this.rank;
    data['state'] = this.state;
    if (this.branches != null) {
      data['branches'] = this.branches?.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location?.toJson();
    }
    return data;
  }

  districtAndBranchExists(List<String> districts, List<String> branchcodes) {
    return districtExists(districts) && branchExists(branchcodes);
  }

  isBranchAvailableInCollege(String element) {
    return this.availableBranchCodes.contains(element);
  }

  bool branchExists(List<String> branchcodesToBeSearched) {
    return branchcodesToBeSearched.isEmpty
        ? true
        : Search.hasAnyCommonItems(
            branchcodesToBeSearched, this.availableBranchCodes);
  }

  bool districtExists(List<String> districts) {
    return districts.isEmpty ? true : districts.contains(this.district);
  }


  bool canGetIntoBranch(
      String branchcode, CommunityGroup communityGroup, double cutOff) {
    return yearsAllowedForCommunityAndCutOff(branchcode, communityGroup, cutOff).length > 0;
  }

  List<YearDetail> yearsAllowedForCommunityAndCutOff(
      String branchcode, CommunityGroup communityGroup, double cutOff) {
    return this
        .yearsAllowedFor(branchcode)
        .where((element) =>
        element.isCutOffEnoughForCommunityGroup(cutOff, communityGroup))
        .toList();

    ;
  }
  List<YearDetail> yearsAllowedFor(
      String branchcode) {
    return this
        .branches!
        .where((element) => element.code == branchcode)
        .map((e) => e.history)
        .expand((element) => element)
        .toList();

    ;
  }

  String? getBranchName(String branchcode) {
    return branches!
        .where((element) => element.code == branchcode)
        .map((e) => e.name)
        .first;

  }


}
