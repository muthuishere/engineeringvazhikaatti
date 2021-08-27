
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';

class SettingsUpdater{

  final Preferences preferences;

  SettingsUpdater(this.preferences){
    

  }
  
  var settings =Settings(physics: 70.0, chemistry:70.0, maths: 70.0,communityGroup: CommunityGroup.BC);

 
  
  Settings getSettings(){
    return settings;
  }
  void update(double physics,double chemistry,double maths,[CommunityGroup? communityGroup]){
    settings.set(physics, chemistry, maths,communityGroup);
    // print("CutOff" + settings.getCutOff().toString());
  }

  void setCommunity(CommunityGroup communityGroup){

    settings.communityGroup=communityGroup;
  }

}

