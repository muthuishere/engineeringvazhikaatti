

import 'package:engineeringvazhikaatti/entities/models/request/college_with_branch.dart';

import '../request/branch_with_cutoff.dart';
import '../request/college_location.dart';

class CollegeDetail {
    String address;
    int code;
    String description;
    String district;
    CollegeLocation location;
    String name;
    String pincode;
    String state;

    CollegeDetail({ required this.address,  required  this.code, required  this.description, required  this.district,  required this.location,  required this.name,  required this.pincode,  required this.state});

    factory CollegeDetail.fromJson(Map<String, dynamic> json) {
        return CollegeDetail(
            address: json['address'],
            code: json['code'], 
            description: json['description'], 
            district: json['district'], 
            location: CollegeLocation.fromJson(json['location']) ,
            name: json['name'], 
            pincode: json['pincode'], 
            state: json['state'], 
        );
    }
    factory CollegeDetail.fromCollegeDetailWithBranches(CollegeWithBranch collegeDetailWithBranches) {
        return CollegeDetail(
            address: collegeDetailWithBranches.address,
            code: collegeDetailWithBranches.code,
            description: collegeDetailWithBranches.description,
            district: collegeDetailWithBranches.district,
            location: collegeDetailWithBranches.location,
            name: collegeDetailWithBranches.name,
            pincode: collegeDetailWithBranches.pincode,
            state: collegeDetailWithBranches.state,

        );
    }

    @override
    String toString() {
        return toJson().toString();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['code'] = this.code;
        data['description'] = this.description;
        data['district'] = this.district;
        data['name'] = this.name;
        data['pincode'] = this.pincode;
        data['state'] = this.state;
        if (this.location != null) {
            data['location'] = this.location.toJson();
        }
        return data;
    }
}