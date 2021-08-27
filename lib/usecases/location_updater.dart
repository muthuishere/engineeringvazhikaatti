
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/entities/models/college_location.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/mark.dart';
import 'package:rxdart/rxdart.dart';

class LocationUpdater{

  final Preferences preferences;
   CollegeLocation? _userLocation =null;
  LocationUpdater(this.preferences){
    

  }

  hasLocation(){
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

    // double? longitude2 = _userLocation?.longitude;
    // print("updated location"+longitude2.toString());
  }
}

