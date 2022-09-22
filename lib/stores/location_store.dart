
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/entities/models/request/college_location.dart';
import 'package:engineeringvazhikaatti/providers/gps/greatcircle/great_circle_distance_base.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

class LocationStore with UiLoggy{

  BehaviorSubject<CollegeLocation> _deviceLocation =
  new BehaviorSubject<CollegeLocation>();

  LocationStore(){
    

  }

  bool hasLocation(){
    return null != _deviceLocation.value;
  }
  getLocation(){
    return  _deviceLocation.value;
  }
  locationStream(){
    return  _deviceLocation.stream;
  }
  setLocation(double lat,double lon){

    logInfo('Setting location to $lat,$lon');
    CollegeLocation input=  CollegeLocation(
      latitude: lat,
      longitude: lon,
    );
    _deviceLocation.sink.add(input);

  }


  double getDistanceBetween(double lat1, double lon1, double lat2, double lon2) {

    var d = getDistanceBetweenInMeters(lat1,lon1,lat2,lon2) / 1000;

    return double.parse((d).toStringAsFixed(2));
  }

  double getDistanceBetweenInMeters(
      double lat1, double lon1, double lat2, double lon2,
      ) {
    /*
  if (!collegeLocation.hasLocation()) return -1;

  var lat1 = collegeLocation.latitude!;
  var lon1 = collegeLocation.longitude!;
   */
    var gcd = new GreatCircleDistance.fromDegrees(
        latitude1: lat1,
        longitude1: lon1,
        latitude2: lat2,
        longitude2: lon2);

    // print('Distance from location 1 to 2 using the Haversine formula is: ${gcd.haversineDistance()}');
    // print('Distance from location 1 to 2 using the Spherical Law of Cosines is: ${gcd.sphericalLawOfCosinesDistance()}');
    // print('Distance from location 1 to 2 using the Vicenty`s formula is: ${gcd.vincentyDistance()}');
    //
    //if (method == 1)
    return gcd.haversineDistance();
    // else if (method == 2)
    //   return gcd.sphericalLawOfCosinesDistance();
    // else
    //   return gcd.vincentyDistance();
  }


  bool withinDistance(CollegeLocation location, int distanceInKilometers) {

    if (distanceInKilometers == 0) return true;
    if (!hasLocation()) {
      logInfo("No location found");
      print("no location found");
      return false;
    }
      var lat1 = getLocation()?.latitude;
      var lon1 = getLocation()?.longitude;
    logInfo("lat1: $lat1, lon1: $lon1");
    print("lat1: $lat1, lon1: $lon1");
      var lat2 = location.latitude;
      var lon2 = location.longitude;
      var distance = getDistanceBetween(lat1!, lon1!, lat2, lon2);
      return distance <= distanceInKilometers;
    }

}

