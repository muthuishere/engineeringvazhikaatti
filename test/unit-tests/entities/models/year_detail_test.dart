import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/YearDetail.dart';
import 'package:test/test.dart';

void main() {
  test('YearDetail should load from JSON and be valid', () {
    var contents = File('testassets/validjson/year.json').readAsStringSync();
    Map<String, dynamic> userMap = jsonDecode(contents);
    var currentYear = YearDetail.fromJson(userMap);
    //{"OC":1781,"BC":2593,"BCM":2271,"MBC":3405,"SC":7952,"SCA":10906,"ST":""}
    expect(currentYear.year, 2018);

    var currentRank = currentYear.rank;
    if (null != currentRank) {
      expect(currentRank.bc, 2593);
      expect(currentRank.mbc, 3405);
      expect(currentRank.bcm, 2271);
      expect(currentRank.oc, 1781);
      expect(currentRank.sc, 7952);
      expect(currentRank.sca, 10906);
      expect(currentRank.st, null);
    }

    var cutOff = currentYear.cutoff;
    if (null != cutOff) {
      expect(cutOff.bc, 196.0);
      expect(cutOff.mbc, 195.25);
      expect(cutOff.bcm, 196.25);
      expect(cutOff.oc, 196.75);
      expect(cutOff.sc, 191.5);
      expect(cutOff.sca, 189.5);
      expect(cutOff.st, null);
    }
  });
}
