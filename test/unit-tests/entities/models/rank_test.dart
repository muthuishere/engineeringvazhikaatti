import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/Rank.dart';
import 'package:test/test.dart';

void main() {
  test('rank data can be loaded from json', () {
    var contents = File('testassets/validjson/rank.json').readAsStringSync();
    Map<String, dynamic> userMap = jsonDecode(contents);
    var currentRank = Rank.fromJson(userMap);
    //{"OC":1781,"BC":2593,"BCM":2271,"MBC":3405,"SC":7952,"SCA":10906,"ST":""}
    expect(currentRank.bc, 2593);
    expect(currentRank.mbc, 3405);
    expect(currentRank.bcm, 2271);
    expect(currentRank.oc, 1781);
    expect(currentRank.sc, 7952);
    expect(currentRank.sca, 10906);
    expect(currentRank.st, null);
  });
}