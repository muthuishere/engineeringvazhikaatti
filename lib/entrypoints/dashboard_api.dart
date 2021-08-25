import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';

class DashboardApi{

  late final SearchCollegesByCommunityAndCutoff _searchCollegesByCommunityAndCutoff;
  late final AvailableCollegesStore _availableCollegesStore;

  DashboardApi(
      this._searchCollegesByCommunityAndCutoff, this._availableCollegesStore);


  updateDashboard(){
    this._availableCollegesStore.showLoading();
    var results  = _searchCollegesByCommunityAndCutoff.byBranchAndDistricts(['CS','IT'], ['Chennai'], 179.2, CommunityGroup.BC);
    this._availableCollegesStore.send(results);
  }
}