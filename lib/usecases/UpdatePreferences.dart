
import '../entities/user/UserPreferences.dart';

class UpdatePreferences{

  var preferences =UserPreferences();

  UserPreferences getPreferences(){
    return preferences;
  }
  void setBranches(List<String> branches){
    preferences.setBranches(branches);
  }
  void setDistricts(List<String> districts){
    preferences.setDistricts(districts);
  }
  void updatePreferences(List<String> branches,List<String> districts){
    setDistricts(districts);
    setBranches(branches);
  }
}