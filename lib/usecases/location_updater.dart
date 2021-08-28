
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/entities/models/college_location.dart';

class LocationUpdater{

  final Preferences preferences;
   CollegeLocation? _userLocation =null;
  LocationUpdater(this.preferences){
    

  }

  bool hasLocation(){
    return null != _userLocation;
  }
  getLocation(){
    return  _userLocation;
  }
  setLocation(double lat,double lon){

    _userLocation=  CollegeLocation(
      latitude: lat,
      longitude: lon,
    );

  }
}

