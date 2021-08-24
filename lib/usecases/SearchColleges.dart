import 'package:engineeringvazhikaatti/adapters/DistanceCalculator.dart';
import 'package:engineeringvazhikaatti/config/DependencyInjector.dart';
import 'package:engineeringvazhikaatti/entities/Settings.dart';
import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableBranch.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';
import '../entities/Filter.dart';
import 'package:engineeringvazhikaatti/usecases/store/AppConfigStore.dart';
import 'package:engineeringvazhikaatti/usecases/store/CollegeDetailsStore.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/results/AvailableCollegeBuilder.dart';

class SearchColleges {

  final AppConfigStore _appConfigStore;

  final CollegeDetailsStore _collegeDetailsStore;

  final AvailableCollegeBuilder _availableCollegeBuilder =
      new AvailableCollegeBuilder();

  final DistanceCalculator _distanceCalculator ;

  SearchColleges(this._appConfigStore, this._collegeDetailsStore,this._distanceCalculator);

  List<AvailableCollege> byBranchAndDistricts(
      List<String> branchcodes, List<String> districts) {

    return _collegeDetailsStore.collegeDetails
        .where((collegeDetail) =>
            collegeDetail.districtAndBranchExists(districts, branchcodes))
        .map((e) => _availableCollegeBuilder.getAvailableCollegeWithBranches(e, branchcodes))
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
        .map((e) => _availableCollegeBuilder.getAvailableCollegeWithBranches(e, branchcodes))
        .toList();
  }

}
