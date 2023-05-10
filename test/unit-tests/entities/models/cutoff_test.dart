import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/request/cutoff.dart';
import 'package:test/test.dart';

void main() {
  test('Cutoff Can be loaded from json', () {
    var contents = File('testassets/validjson/cutoff.json').readAsStringSync();
    Map<String, dynamic> userMap = jsonDecode(contents);
    var cutOff = Cutoff.fromJson(userMap);
    //{"OC":196.75,"BC":196,"BCM":196.25,"MBC":195.25,"SC":191.5,"SCA":189.5,"ST":""}
    expect(cutOff.bc, 196.0);
    expect(cutOff.mbc, 195.25);
    expect(cutOff.bcm, 196.25);
    expect(cutOff.oc, 196.75);
    expect(cutOff.sc, 191.5);
    expect(cutOff.sca, 189.5);
    expect(cutOff.st, null);


  });
}