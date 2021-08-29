import 'package:engineeringvazhikaatti/entities/distance_option.dart';
import 'package:engineeringvazhikaatti/entities/models/engg_branch.dart';
import 'package:test/test.dart';

import '../../shared/TestDataGenerator.dart';

void main() {
  test('get getBranch should work fine for valid', () {

      var store= TestDataGenerator.getAppConfigStore();
     EnggBranch? enggBranch= store.getBranch("CS");
     expect(null != enggBranch, true);
     expect(enggBranch!.name, "Computer Science and Engineering");

  });


  test('get getBranch should return null for invalid', () {

      var store= TestDataGenerator.getAppConfigStore();
     EnggBranch? enggBranch= store.getBranch("ASSSCS");
     expect(null == enggBranch, true);


  });


  test('get distance should work fine', () {

      var store= TestDataGenerator.getAppConfigStore();
     DistanceOption? distanceOption= store.getDistance(100);
     expect(null != distanceOption, true);
     expect(distanceOption!.label, "Less than 100 Kms");

  });


  test('get distance should return null for invalid', () {

    var store= TestDataGenerator.getAppConfigStore();
    DistanceOption? distanceOption= store.getDistance(8989);
    expect(null == distanceOption, true);


  });


}