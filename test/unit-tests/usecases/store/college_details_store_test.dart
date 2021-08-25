import 'dart:io';

import 'package:test/test.dart';

import '../shared/TestDataGenerator.dart';

void main() {
  test('College Details Store test', () {


    var collegeDetailsStore = TestDataGenerator.getCollegeDetailsStore();
    expect(collegeDetailsStore.collegeDetails.length, 441);
  });
}

