

import 'branch_with_cutoff.dart';
import 'college_location.dart';

class CollegeWithBranch {
    String address;
    List<BranchWithCutoff> branches;
    int code;
    String description;
    String district;
    CollegeLocation location;
    String name;
    String pincode;
    String state;

    CollegeWithBranch({ required this.address, required this.branches, required  this.code, required  this.description, required  this.district,  required this.location,  required this.name,  required this.pincode,  required this.state});

    @override
    String toString() {
        return toJson().toString();
    }


    factory CollegeWithBranch.fromJson(Map<String, dynamic> json) {

        return CollegeWithBranch(
            address: json['address'], 
            branches:  (json['branches'] as List).map((i) => BranchWithCutoff.fromJson(i)).toList() ,
            code: json['code'], 
            description: json['description'], 
            district: json['district'], 
            location: CollegeLocation.fromJson(json['location']) ,
            name: json['name'], 
            pincode: json['pincode'], 
            state: json['state'], 
        );
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
        final branches = this.branches;
        if (branches != null) {
            data['branches'] = branches.map((v) => v.toJson()).toList();
        }
        if (this.location != null) {
            data['location'] = this.location.toJson();
        }
        return data;
    }

    withinAnyOfDistricts(List<String> districts) {

        if (districts.length == 0) {
            return true;
        }
        return districts.contains(this.district);
    }

}