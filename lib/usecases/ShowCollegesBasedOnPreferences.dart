import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableBranch.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';
import 'package:engineeringvazhikaatti/entities/user/UserPreferences.dart';
import 'package:engineeringvazhikaatti/entities/user/UserProfile.dart';
import 'package:engineeringvazhikaatti/usecases/store/AppConfigStore.dart';
import 'package:engineeringvazhikaatti/usecases/store/CollegeDetailsStore.dart';
import 'package:rxdart/rxdart.dart';

import 'AvailableCollegeBuilder.dart';

class ShowCollegesBasedOnPreferences {
  final AppConfigStore _appConfigStore;
  final CollegeDetailsStore _collegeDetailsStore;
  final AvailableCollegeBuilder _availableCollegeBuilder=new AvailableCollegeBuilder();

  ShowCollegesBasedOnPreferences(
      this._appConfigStore, this._collegeDetailsStore);

  List<CollegeDetail> byPreferences(UserPreferences userPreferences) {
    List<String> branchcodes = userPreferences.branchCodes;
    List<String> districts = userPreferences.districts;

    return _collegeDetailsStore.collegeDetails
        .where((collegeDetail) =>
            collegeDetail.sameDistrictAndBranch(districts, branchcodes))
        .toList();
  }
  List<AvailableCollege> byPreferencesAndProfile(UserPreferences userPreferences,UserProfile profile) {
    List<String> branchcodes = userPreferences.branchCodes;
    double cutOff = profile.getCutOff();
    CommunityGroup communityGroup = profile.communityGroup;

    return byPreferences(userPreferences)
        .map((collegeDetail) =>
        _availableCollegeBuilder.getAvailableCollegeWithBranches(collegeDetail, branchcodes,communityGroup,cutOff))
        .where((element) => element.isValidCollege())
        .toList();
  }


}
