import 'package:engineeringvazhikaatti/entities/models/response/college_detail.dart';

import 'branch.dart';
import 'college_with_branch.dart';




class AppData {
    List<Branch> branches;
    List<CollegeWithBranch> allcollegedata;
    List<String> communities;
    List<String> districts;


    AppData({required this.branches, required this.allcollegedata,required  this.communities,required  this.districts});

    factory AppData.fromJson(Map<String, dynamic> json) {
        return AppData(
            branches: (json['branches'] as List).map((i) => Branch.fromJson(i)).toList() ,
            allcollegedata:  (json['allcollegedata'] as List).map((i) => CollegeWithBranch.fromJson(i)).toList() ,
            communities: new List<String>.from(json['communities']) ,
            districts: new List<String>.from(json['districts']) ,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.branches != null) {
            data['branches'] = this.branches.map((v) => v.toJson()).toList();
        }
        if (this.allcollegedata != null) {
            data['allcollegedata'] = this.allcollegedata.map((v) => v.toJson()).toList();
        }
        if (this.communities != null) {
            data['communities'] = this.communities;
        }
        if (this.districts != null) {
            data['districts'] = this.districts;
        }
        return data;
    }
}