import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';
import 'package:engineeringvazhikaatti/usecases/sort_colleges.dart';

class DashboardApi {
  late final SearchCollegesByCommunityAndCutoff
      _searchCollegesByCommunityAndCutoff;
  late final SortColleges _sortColleges;
  late final AvailableCollegesStore _availableCollegesStore;
  late final SearchFilterStore _searchFilterStore;
  late final SettingsUpdater _settingsUpdater;
  late final LocationUpdater _locationUpdater;
  late final AppConfigStore _appConfigStore;
  String msg = "";

  DashboardApi(
    this._searchCollegesByCommunityAndCutoff,
    this._availableCollegesStore,
    this._searchFilterStore,
    this._settingsUpdater,
    this._locationUpdater,
    this._appConfigStore,
    this._sortColleges,
  );

  updateDashboardOld() {
    this._availableCollegesStore.showLoading();
    var results = _searchCollegesByCommunityAndCutoff.byBranchAndDistricts(
        ['CS', 'IT'], ['Chennai'], 184, CommunityGroup.BC);
    this._availableCollegesStore.send(results);
  }

  updateDashboard() {
    msg = "";
    _searchFilterStore.searchMsg = msg;
    this._availableCollegesStore.showLoading();

    if (!_settingsUpdater.hasAllData()) {
      this._availableCollegesStore.showError("Please Update Cutoff Details");
      return;
    }

    if (_searchFilterStore.searchByDistrictsEnabled) {
      updateDashboardByDistrict();
    } else {
      updateDashboardByDistance();
    }

    _searchFilterStore.searchMsg = msg;
  }

  updateDashboardByDistrict() {
    if (!_searchFilterStore.hasDistrictsSelected()) {
      this
          ._availableCollegesStore
          .showError("Please Select Districts to Continue");
      return;
    }

    var branchCodes = getBranchCodes();
    var branchCodeToBeSorted = branchCodes[0];


    var districts = _searchFilterStore.searchFilter.districts;

    msg = "Searching on " +
        branchCodes.length.toString() +
        " branches &  " +
        districts.length.toString() +
        " districts / sorted by" +
        branchCodeToBeSorted +
        " Branch ";

    var results = _searchCollegesByCommunityAndCutoff.byBranchAndDistricts(
        branchCodes,
        districts,
        _settingsUpdater.settings.getCutOff(),
        _settingsUpdater.settings.communityGroup);

    sortAndSend(results, branchCodeToBeSorted);
  }

  updateDashboardByDistance() {
    if (!_locationUpdater.hasLocation()) {
      this._availableCollegesStore.showError("Please Enable Gps to Continue");
      return;
    }

    if (!_searchFilterStore.hasDistanceInKmsSelected()) {
      this._availableCollegesStore.showError("Please Select Distance in Kms");
      return;
    }

    //
   // print(_locationUpdater.getLocation()?.getLat());
   // print(_locationUpdater.getLocation()?.getLon());
    var maximumDistanceCandidateCanTravel =
        _searchFilterStore.searchFilter.distanceInKms!.toDouble();
    //print(maximumDistanceCandidateCanTravel);

    var branchCodes = getBranchCodes();
    var branchCodeToBeSorted = branchCodes[0];


    msg = "Searching on " +
        branchCodes.length.toString() +
        " branches within " +
        maximumDistanceCandidateCanTravel.toInt().toString() +
        " kms / sorted by " +
        branchCodeToBeSorted +
        " Branch ";

    var results = _searchCollegesByCommunityAndCutoff.byBranchAndDistance(
        branchCodes,
        _settingsUpdater.settings.getCutOff(),
        _settingsUpdater.settings.communityGroup,
        _locationUpdater.getLocation()?.getLat(),
        _locationUpdater.getLocation()?.getLon(),
        maximumDistanceCandidateCanTravel);


    sortAndSend(results, branchCodeToBeSorted);
  }

  void sortAndSend(
      List<AvailableCollege> results, String branchCodeToBeSorted) {
   // print(results.length);
    // var sortedResults=results;
    var sortedResults = _sortColleges.sortByRank(results, branchCodeToBeSorted);
    //
    // print("filtering with" + msg);
    // print(sortedResults);
    msg= msg+" resulted in " + sortedResults.length.toString() + " Colleges";
    this._availableCollegesStore.send(sortedResults);
  }

  List<String> getBranchCodes() {
    List<String> branchCodes = _searchFilterStore.searchFilter.branchCodes;

    if (branchCodes.isEmpty) {
      print("Branch codes is empty , returning more");
      branchCodes = _appConfigStore.getBranches().map((e) => e.code!).toList();
    }
   // print("retu branchCodes");
    //print(branchCodes);
    return branchCodes;
  }
}
