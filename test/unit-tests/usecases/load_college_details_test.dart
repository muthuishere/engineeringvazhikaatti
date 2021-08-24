import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import '../../../lib/usecases/store/CollegeDetailsStore.dart';
import 'package:test/test.dart';

void main() {
  test('List of College Detail should load from JSON and be valid', () {
    var contents = File('testassets/validjson/listofcollegedetail.json').readAsStringSync();
    var loadCollegeDetails =  CollegeDetailsStore();


    List<CollegeDetail> collegeDetails = loadCollegeDetails.load(contents);
    // "id": 1,
    // "name": "University Departments of Anna University",
    // "address": "University Departments of Anna University, Chennai - CEG Campus, Sardar Patel Road, Guindy, Chennai 600 025",
    // "district": "Chennai",
    // "pincode": "600025",
    // "state": "TamilNadu",
    //
    expect(collegeDetails.length, 3);
    print(collegeDetails.map((e) => e.toJson()).toString());
  });
}