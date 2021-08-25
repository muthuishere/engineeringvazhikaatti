import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/college_location.dart';
import 'package:engineeringvazhikaatti/entities/models/cutoff.dart';
import 'package:test/test.dart';
import 'dart:convert';


void main() {
  test('College Location Can be loaded from json', () {
    var contents = File('testassets/validjson/collegelocation.json').readAsStringSync();
    Map<String, dynamic> userMap = jsonDecode(contents);
    var collegeLocation = CollegeLocation.fromJson(userMap);
    expect(collegeLocation.latitude, 13.0484);
    expect(collegeLocation.longitude, 80.2473);
  });
}