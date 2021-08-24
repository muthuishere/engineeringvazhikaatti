import 'package:engineeringvazhikaatti/adapters/DistanceCalculator.dart';
import 'package:engineeringvazhikaatti/config/DependencyInjector.dart';
import 'package:engineeringvazhikaatti/entities/Settings.dart';
import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableBranch.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollegeBuilderForCommunityAndCutoff.dart';
import '../entities/Filter.dart';
import 'package:engineeringvazhikaatti/usecases/store/AppConfigStore.dart';
import 'package:engineeringvazhikaatti/usecases/store/CollegeDetailsStore.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/results/AvailableCollegeBuilder.dart';

class SearchCollegesByCommunityAndCutoff {


  final CollegeDetailsStore _collegeDetailsStore;


  final DistanceCalculator _distanceCalculator;

  SearchCollegesByCommunityAndCutoff(this._collegeDetailsStore, this._distanceCalculator);

  List<AvailableCollege> byBranchAndDistricts(List<String> branchcodes,
      List<String> districts, double cutOff, CommunityGroup communityGroup) {

    List<AvailableCollege> results = _collegeDetailsStore.collegeDetails
        .where((collegeDetail) =>
            collegeDetail.districtAndBranchExists(districts, branchcodes))
        .map<AvailableCollege>((collegeDetail) =>
            getAvailableCollegeWithBranches(
                collegeDetail, branchcodes, communityGroup, cutOff))
        .toList();

    results.sort((a, b) {
      return a
          .getRankForSortableBranch()
          .compareTo(b.getRankForSortableBranch());
    });

    return results;
  }

  List<AvailableCollege> byBranchAndDistance(
      List<String> branchcodes,
      double cutOff,
      CommunityGroup communityGroup,
      double lat2,
      double lon2,
      double kms) {
    List<AvailableCollege> results = _collegeDetailsStore.collegeDetails
        .where((collegeDetail) => collegeDetail.branchExists(branchcodes))
        .where((element) =>
            kms <
            _distanceCalculator.getDistanceBetween(element.location!.latitude!,
                element.location!.longitude!, lat2, lon2))
        .map<AvailableCollege>((collegeDetail) =>
            getAvailableCollegeWithBranches(
                collegeDetail, branchcodes, communityGroup, cutOff))
        .toList();

    return results;
  }

  AvailableCollege getAvailableCollegeWithBranches(CollegeDetail collegeDetail,
      List<String> branchcodes, CommunityGroup communityGroup, double cutOff) {
    List<AvailableBranch> branches = getAvailableBranchesFrom(
        collegeDetail, branchcodes, communityGroup, cutOff);
    return AvailableCollege.build(collegeDetail, branches);
  }


  List<AvailableBranch> getAvailableBranchesFrom(CollegeDetail collegeDetail,
      List<String> branchcodes, CommunityGroup communityGroup, double cutOff) {
    return branchcodes
        .where((element) => collegeDetail.isBranchAvailableInCollege(element))
        .map((branchcode) => getAvailableBranchFrom(
        collegeDetail, branchcode, communityGroup, cutOff))
        .toList();
  }

  AvailableBranch getAvailableBranchFrom(CollegeDetail collegeDetail,
      String branchcode, CommunityGroup communityGroup, double cutOff) {
    List<AvailableYearDetail> years =
    collegeDetail.yearsAllowedForCommunityAndCutOff(branchcode, communityGroup, cutOff)
        .where((element) => null !=element.rankFor(communityGroup))
        .where((element) => null !=element.cutOffFor(communityGroup))
        .map((e) => AvailableYearDetail(e.cutOffFor(communityGroup),e.rankFor(communityGroup),e.year,e.branchRank))
        .toList();

    String? branchName = collegeDetail.getBranchName(branchcode);
    return AvailableBranch(branchcode, branchName, years);
  }
}
