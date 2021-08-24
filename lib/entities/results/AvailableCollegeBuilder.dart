import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/models/YearDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableBranch.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableYearDetail.dart';

class AvailableCollegeBuilder {
  AvailableCollege getAvailableCollegeWithBranches(
      CollegeDetail collegeDetail, List<String> branchcodes) {
    List<AvailableBranch> branches =
        getAvailableBranchesFrom(collegeDetail, branchcodes);
    return AvailableCollege.build(collegeDetail, branches);
  }

  List<AvailableBranch> getAvailableBranchesFrom(
      CollegeDetail collegeDetail, List<String> branchcodes) {
    return branchcodes
        .where((element) => collegeDetail.isBranchAvailableInCollege(element))
        .map((branchcode) => getAvailableBranchFrom(collegeDetail, branchcode))
        .toList();
  }

  AvailableBranch getAvailableBranchFrom(
      CollegeDetail collegeDetail, String branchcode) {
    List<AvailableYearDetail> years = collegeDetail
        .yearsAllowedFor(branchcode)
        .map((e) => AvailableYearDetail(e.cutOffFor(CommunityGroup.OC),
            e.rankFor(CommunityGroup.OC), e.year, e.branchRank))
        .toList();

    String? branchName = collegeDetail.getBranchName(branchcode);
    return AvailableBranch(branchcode, branchName, years);
  }
}
