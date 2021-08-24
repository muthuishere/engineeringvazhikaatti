
import 'package:engineeringvazhikaatti/adapters/DistanceCalculator.dart';
import 'package:engineeringvazhikaatti/networks/gps/greatcircle/GreatCircleDistanceCalculator.dart';

class DependencyInjector{

  static DistanceCalculator getDistanceCalculator(){
    return GreatCircleDistanceCalculator();
  }
}
