import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/models/YearDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableBranch.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';

class AvailableCollegeBuilder {
  AvailableCollege getAvailableCollegeWithBranches(CollegeDetail collegeDetail,
      List<String> branchcodes, CommunityGroup communityGroup, double cutOff) {
    List<AvailableBranch?> branches = getAvailableBranchesFrom(
        collegeDetail, branchcodes, communityGroup, cutOff);
    return AvailableCollege.build(collegeDetail, branches);
  }

  List<AvailableBranch?> getAvailableBranchesFrom(CollegeDetail collegeDetail,
      List<String> branchcodes, CommunityGroup communityGroup, double cutOff) {
    return branchcodes
        .where((element) => collegeDetail.isBranchAvailableInCollege(element))
        .map((branchcode) => getAvailableBranchFrom(
            collegeDetail, branchcode, communityGroup, cutOff))
        .toList();
  }

  AvailableBranch? getAvailableBranchFrom(CollegeDetail collegeDetail,
      String branchcode, CommunityGroup communityGroup, double cutOff) {
    List<YearDetail> years =
        collegeDetail.yearsAllowedFor(branchcode, communityGroup, cutOff);

    String? branchName = collegeDetail.getBranchName(branchcode);
    return AvailableBranch(branchcode, branchName, years);
  }
}
