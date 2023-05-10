
import 'package:engineeringvazhikaatti/entities/models/request/college_location.dart';

abstract class DistanceCalculator{

  double getDistanceBetween(double lat1, double lon1, double lat2, double lon2);

  bool withinDistance(CollegeLocation location, int distanceInKilometers);

}
