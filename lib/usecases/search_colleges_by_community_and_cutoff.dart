import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';
import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_branch.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entities/results/available_year_detail.dart';
import 'package:engineeringvazhikaatti/stores/college_details_store.dart';

class SearchCollegesByCommunityAndCutoff {
  final CollegeDetailsStore _collegeDetailsStore;

  final DistanceCalculator _distanceCalculator;

  SearchCollegesByCommunityAndCutoff(
      this._collegeDetailsStore, this._distanceCalculator);

  List<AvailableCollege> byBranchAndDistricts(List<String> branchcodes,
      List<String> districts, double cutOff, CommunityGroup communityGroup) {
    List<AvailableCollege> results = _collegeDetailsStore.collegeDetails
        .where((collegeDetail) =>
            collegeDetail.districtAndBranchExists(districts, branchcodes))
        .map<AvailableCollege>((collegeDetail) =>
            getAvailableCollegeWithBranches(
                collegeDetail, branchcodes, communityGroup, cutOff))
        .where((element) => element.hasAnyYears())
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
        .where((element) => within(kms, element, lat2, lon2))
        .map<AvailableCollege>((collegeDetail) =>
            getAvailableCollegeWithBranches(
                collegeDetail, branchcodes, communityGroup, cutOff))
        .where((element) => element.hasAnyYears())
        .toList();

    return results;
  }

  bool within(double maximumDistanceToTravel, CollegeDetail element, double lat2, double lon2) {
    // print("Checking distance for" +
    //     element.name! +
    //     element.id.toString() +
    //     "from" +
    //     element.location!.latitude!.toString() +
    //     "[" +
    //     element.location!.longitude!.toString() +
    //     "==" +
    //     lat2.toString() +
    //     lon2.toString());
    bool res = false;
    try {
      var actualDistance
      = _distanceCalculator.getDistanceBetween(element.location!.latitude!,
              element.location!.longitude!, lat2, lon2);

      res = actualDistance <maximumDistanceToTravel
          ;
    //  print("checking with" +maximumDistanceToTravel.toString() + "against" +actualDistance.toString() +" result " + res.toString());
    } catch (e) {
      print("error in Distance calculation");
      print(e);
    }

    return res;
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
    List<AvailableYearDetail> years = collegeDetail
        .yearsAllowedForCommunityAndCutOff(branchcode, communityGroup, cutOff)
        .where((element) => null != element.rankFor(communityGroup))
        .where((element) => null != element.cutOffFor(communityGroup))
        .map((e) => AvailableYearDetail(e.cutOffFor(communityGroup),
            e.rankFor(communityGroup), e.year, e.branchRank))
        .toList();

    String? branchName = collegeDetail.getBranchName(branchcode);
    return AvailableBranch(branchcode, branchName, years);
  }
}
