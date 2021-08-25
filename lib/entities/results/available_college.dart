
import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/college_location.dart';
import 'available_branch.dart';


@JsonSerializable()
class AvailableCollege {
  String? district;
  int? id;
  CollegeLocation? location;
  String? name;
  String? pincode;
  String? address;

  String? state;
  List<AvailableBranch>? branches = List.empty();
  late AvailableBranch? sortableBranch;

  factory AvailableCollege.build(CollegeDetail collegeDetail,List<AvailableBranch> branches){

    List<AvailableBranch> validBranches = branches.where((element) => element.isValidBranch()).toList();

    return AvailableCollege(collegeDetail.id,collegeDetail.name,collegeDetail.district,
              collegeDetail.location,collegeDetail.pincode,
    collegeDetail.state,validBranches,collegeDetail.address);
  }

  AvailableCollege( this.id, this.name,this.district,this.location,
      this.pincode, this.state,this.branches,this.address){

    setSortableBranch();
  }

  AvailableCollege.fromOptions(
      {this.address,
        this.district,
        this.id,
        this.location,
        required this.name,
        this.pincode,
        required this.branches,
        this.state}) {
    setSortableBranch();
  }

  void setSortableBranch() {
    sortableBranch=(null == this.branches || this.branches!.isEmpty)?null:this.branches![0];
  }
  void setSortableBranchWithCode(String code) {

    this.sortableBranch = this.branches?.firstWhereOrNull((element) => element.code==code);

  }

  bool isValidCollege(){

     return null != sortableBranch;

  }

  int getRankForSortableBranch(){
    return isValidCollege()?sortableBranch!.getRank():99999;
  }


  factory AvailableCollege.fromJson(Map<String, dynamic> json) {
    return AvailableCollege.fromOptions(
      address: json['address'],
      branches: json['branches'] != null
          ? (json['branches'] as List)
          .map((i) => AvailableBranch.fromJson(i))
          .toList()
          : null,
      district: json['district'],
      id: json['id'],
      location: json['location'] != null
          ? CollegeLocation.fromJson(json['location'])
          : null,
      name: json['name'],
      pincode: json['pincode'],
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
    data['state'] = this.state;
    if (this.branches != null) {
      data['branches'] = this.branches?.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location?.toJson();
    }
    return data;
  }



}
