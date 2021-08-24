
import 'package:engineeringvazhikaatti/entities/Settings.dart';
import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/mark.dart';
import 'package:rxdart/rxdart.dart';

class SettingsUpdater{

  var profile =Settings(physics: 70.0, chemistry:70.0, maths: 70.0,communityGroup: CommunityGroup.BC);
  
  Settings getProfile(){
    return profile;
  }
  void setProfile(double physics,double chemistry,double maths,[CommunityGroup? communityGroup]){
    profile.set(physics, chemistry, maths,communityGroup);
  }

  void setCommunity(CommunityGroup communityGroup){

    profile.communityGroup=communityGroup;
  }
}

