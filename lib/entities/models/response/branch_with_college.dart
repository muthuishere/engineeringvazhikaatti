import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';

import 'college_detail.dart';
import '../request/branch_with_cutoff.dart';

import '../request/college_with_branch.dart';
import '../request/cutoff_by_year.dart';

class BranchWithCollege{
  String code;
  String name;
  CollegeDetail collegeDetail;
  double cutoff;
  Map<int,double> cutoffs;

  BranchWithCollege({required this.code, required this.name, required this.collegeDetail, required this.cutoff, required this.cutoffs});

  factory BranchWithCollege.fromCollegeDetailWithBranches(CollegeWithBranch collegeDetail ,BranchWithCutoff branchWithCutoff,CommunityGroup communityGroup,int year) {
    double currentYearCutOff = branchWithCutoff.getCutoffForYearAndCommunity( year, communityGroup);

    var cutoffs = branchWithCutoff.cutOffsForCommunity(communityGroup);

    return BranchWithCollege(
      collegeDetail: CollegeDetail.fromCollegeDetailWithBranches(collegeDetail),
      code: branchWithCutoff.code,
      name: branchWithCutoff.name,
      cutoff:currentYearCutOff,
      cutoffs: cutoffs

    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
  Map<String, dynamic> toJson() {




    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cutoffs != null) {
      //map to comma seperated string
      data['cutoffs'] = cutoffs.entries.map((e) => "${e.key}:${e.value}").join(",");

    }

    data['code'] =code.toString();
    data['name'] =name.toString();
    data['cutoff'] =cutoff.toString();
    data['collegeDetail'] =collegeDetail.toString();

    return data;
  }
  double cutOffForYear( int year) {
    double? cutOffForYear = cutoffs[year];
    if (null != cutOffForYear )
      return cutOffForYear;
    else
      return 0;
  }
}