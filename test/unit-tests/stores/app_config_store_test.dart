import 'package:engineeringvazhikaatti/entities/distance_option.dart';
import 'package:test/test.dart';

import '../../shared/TestDataGenerator.dart';



void main() {
  test('Appconfigstore should load all data specified', () {

      var store= TestDataGenerator.getFullAppConfigStore();
      expect(store, isNotNull);
      expect(store.getAllCollegeDetails().length, greaterThan(1));
      expect(store.getBranches().length, greaterThan(1));
      expect(store.getAllCollegeDetailWithBranches().length, greaterThan(1));
      expect(store.getDistricts().length, greaterThan(1));
      expect(store.getDistances().length, greaterThan(1));


  });







  test('get distance should work fine', () {

      var store= TestDataGenerator.getFullAppConfigStore();
     DistanceOption? distanceOption= store.getDistance(100);
     expect(null != distanceOption, true);
     expect(distanceOption!.label, "Less than 100 Kms");

  });


  test('get distance should return null for invalid', () {

    var store= TestDataGenerator.getFullAppConfigStore();
    DistanceOption? distanceOption= store.getDistance(8989);
    expect(null == distanceOption, true);


  });


}