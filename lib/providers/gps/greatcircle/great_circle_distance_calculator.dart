import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';


import 'great_circle_distance_base.dart';

class GreatCircleDistanceCalculator implements DistanceCalculator{



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
}

