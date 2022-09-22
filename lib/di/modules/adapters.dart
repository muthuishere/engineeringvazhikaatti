import 'package:engineeringvazhikaatti/adapters/app_preferences.dart';
import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';
import 'package:engineeringvazhikaatti/adapters/file_reader.dart';
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/providers/gps/greatcircle/great_circle_distance_calculator.dart';
import 'package:engineeringvazhikaatti/providers/io/flutter_file_reader.dart';
import 'package:engineeringvazhikaatti/providers/io/flutter_preferences.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adapters {
  DistanceCalculator getDistanceCalculator() {
    return GreatCircleDistanceCalculator();
  }
  Future<AppPreferences> getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return AppPreferences(prefs);
  }

  init() async {


    final injector = Injector.appInstance;

    var prefs = await getPreferences();
    injector
        .registerSingleton<DistanceCalculator>(() => getDistanceCalculator());
    injector
        .registerSingleton<AppPreferences>(() => prefs);
    injector.registerSingleton<FileReader>(() => FlutterFileReader());
  }
}
