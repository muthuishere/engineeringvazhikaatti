import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';
import 'package:test/test.dart';

import '../models/college_detail_test.dart';

void main() {
  test('Test Within Area', () {
    AvailableCollege collegeDetail = getMockedAvailableCollegeDetails()![0];
    var lat = 13.0532;
    var lon = 80.1922;

    expect(collegeDetail.isWithin(lat, lon, 25), true);
  });
}

List<AvailableCollege> getMockedAvailableCollegeDetails() {
  String contents =
      File('testassets/available_colleges.json').readAsStringSync();
  Iterable iterableContents = json.decode(contents);
  var items =
      iterableContents.map((content) => AvailableCollege.fromJson(content));
  return List<AvailableCollege>.from(items);
}
