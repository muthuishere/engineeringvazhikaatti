import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';
import 'package:engineeringvazhikaatti/adapters/file_reader.dart';
import 'package:engineeringvazhikaatti/adapters/preferences.dart';
import 'package:engineeringvazhikaatti/providers/gps/greatcircle/great_circle_distance_calculator.dart';
import 'package:engineeringvazhikaatti/providers/io/flutter_file_reader.dart';
import 'package:engineeringvazhikaatti/providers/io/flutter_preferences.dart';
import 'package:injector/injector.dart';

class Adapters {
  DistanceCalculator getDistanceCalculator() {
    return GreatCircleDistanceCalculator();
  }
  Preferences getPreferences() {
    return FlutterPreferences();
  }

  init() {
    final injector = Injector.appInstance;
    injector
        .registerSingleton<DistanceCalculator>(() => getDistanceCalculator());
    injector
        .registerSingleton<Preferences>(() => getPreferences());
    injector.registerSingleton<FileReader>(() => FlutterFileReader());
  }
}
