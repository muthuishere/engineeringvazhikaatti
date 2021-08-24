
import '../entities/Filter.dart';

class PreferencesUpdater{

  var preferences =Filter();

  Filter getPreferences(){
    return preferences;
  }
  void setBranchCodes(List<String> branchCodes){
    preferences.setBranchCodes(branchCodes);
  }
  void setDistricts(List<String> districts){
    preferences.setDistricts(districts);
  }
  void updatePreferences(List<String> branches,List<String> districts){
    setDistricts(districts);
    setBranchCodes(branches);
  }
}