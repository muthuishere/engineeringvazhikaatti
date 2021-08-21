import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';

import '../models/CollegeLocation.dart';
import 'AvailableBranch.dart';
class AvailableCollege {
  String? district;
  int? id;
  CollegeLocation? location;
  String? name;
  String? pincode;
  String? rank;
  String? state;
  List<AvailableBranch?> branches = List.empty();

  factory AvailableCollege.build(CollegeDetail collegeDetail,List<AvailableBranch?> branches){

    List<AvailableBranch?> validBranches = branches.where((element) => element!.isValidBranch()).toList();

    return AvailableCollege(collegeDetail.id,collegeDetail.name,collegeDetail.district,
              collegeDetail.location,collegeDetail.pincode,
    collegeDetail.rank,collegeDetail.state,validBranches);
  }

  AvailableCollege( this.id, this.name,this.district,this.location,
      this.pincode, this.rank, this.state,this.branches);

  bool isValidCollege(){
    if(null == branches || branches.isEmpty)
      return false;

     return true;

  }
}
