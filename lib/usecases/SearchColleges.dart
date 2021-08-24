import 'package:engineeringvazhikaatti/adapters/DistanceCalculator.dart';
import 'package:engineeringvazhikaatti/config/DependencyInjector.dart';
import 'package:engineeringvazhikaatti/entities/Settings.dart';
import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableBranch.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableYearDetail.dart';
import '../entities/Filter.dart';
import 'package:engineeringvazhikaatti/usecases/store/AppConfigStore.dart';
import 'package:engineeringvazhikaatti/usecases/store/CollegeDetailsStore.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/results/AvailableCollegeBuilder.dart';

class SearchColleges {


  final CollegeDetailsStore _collegeDetailsStore;


  final DistanceCalculator _distanceCalculator ;

  SearchColleges(this._collegeDetailsStore,this._distanceCalculator);

  List<AvailableCollege> byBranchAndDistricts(
      List<String> branchcodes, List<String> districts) {

    return _collegeDetailsStore.collegeDetails
        .where((collegeDetail) =>
            collegeDetail.districtAndBranchExists(districts, branchcodes))
        .map((e) => getAvailableCollegeWithBranches(e, branchcodes))
        .toList();
  }

  List<AvailableCollege> byBranchAndDistance(
      List<String> branchcodes, double lat2, double lon2, double kms) {

    return _collegeDetailsStore.collegeDetails
        .where((collegeDetail) => collegeDetail.branchExists(branchcodes))
        .where((element) =>
            kms <
            _distanceCalculator.getDistanceBetween(element.location!.latitude!,
                element.location!.longitude!, lat2, lon2))
        .map((e) => getAvailableCollegeWithBranches(e, branchcodes))
        .toList();
  }

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
