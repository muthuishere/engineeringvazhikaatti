import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';

class DashboardApi{

  late final SearchCollegesByCommunityAndCutoff _searchCollegesByCommunityAndCutoff;
  late final AvailableCollegesStore _availableCollegesStore;
  late final SearchFilterStore _searchFilterStore;
  late final SettingsUpdater _settingsUpdater;
  late final LocationUpdater _locationUpdater;

  DashboardApi(
      this._searchCollegesByCommunityAndCutoff,
      this._availableCollegesStore,
      this._searchFilterStore,
      this._settingsUpdater,
      this._locationUpdater,
      );


  updateDashboard(){


    this._availableCollegesStore.showLoading();

    if(!_settingsUpdater.settings.hasAllData()){
      this._availableCollegesStore.showError("Please Update Cutoff Details");
      return;
    }

    if(_searchFilterStore.searchByDistrictsEnabled){
      return updateDashboardByDistrict();
    }else{
      return updateDashboardByDistance();
    }


  }

  updateDashboardByDistrict() {

    if(!_searchFilterStore.searchFilter.hasDistricts()){
      this._availableCollegesStore.showError("Please Select Districts to Continue");
      return;
    }
    var results  = _searchCollegesByCommunityAndCutoff.byBranchAndDistricts(_searchFilterStore.searchFilter.branchCodes, _searchFilterStore.searchFilter.districts, _settingsUpdater.settings.getCutOff(), _settingsUpdater.settings.communityGroup);
    this._availableCollegesStore.send(results);
  }

  updateDashboardByDistance() {
    if(!_locationUpdater.hasLocation()){
      this._availableCollegesStore.showError("Please Enable Gps to Continue");
      return;
    }

    if(!_searchFilterStore.searchFilter.hasDistanceInKms()){
      this._availableCollegesStore.showError("Please Select Distance in Kms");
      return;
    }
    var results  = _searchCollegesByCommunityAndCutoff.byBranchAndDistance(_searchFilterStore.searchFilter.branchCodes,
        _settingsUpdater.settings.getCutOff(),
        _settingsUpdater.settings.communityGroup,
        _locationUpdater.getLocation()?.getLat(),
        _locationUpdater.getLocation()?.getLon(),
        _searchFilterStore.searchFilter.distanceInKms!.toDouble()
    );
    this._availableCollegesStore.send(results);
  }
}