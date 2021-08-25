import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/engg_branch.dart';
import 'package:test/test.dart';

void main() {
  test('Branch Detail should load from JSON and be valid', () {
    var contents = File('testassets/validjson/branch.json').readAsStringSync();
    Map<String, dynamic> userMap = jsonDecode(contents);
    var branch = EnggBranch.fromJson(userMap);
    //{"OC":1781,"BC":2593,"BCM":2271,"MBC":3405,"SC":7952,"SCA":10906,"ST":""}
    expect(branch.code, 'CE');
    expect(branch.history?.length, 3);
    print(branch.toJson());
  });
}