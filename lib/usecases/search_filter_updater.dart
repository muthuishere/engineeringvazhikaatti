
import '../entities/filter.dart';

class SearchFilterUpdater{

  var searchFilter =Filter();

  Filter getPreferences(){
    return searchFilter;
  }
  void setBranchCodes(List<String> branchCodes){
    searchFilter.setBranchCodes(branchCodes);
  }
  void setDistricts(List<String> districts){
    searchFilter.setDistricts(districts);
  }
  void updatePreferences(List<String> branches,List<String> districts){
    setDistricts(districts);
    setBranchCodes(branches);
  }
}