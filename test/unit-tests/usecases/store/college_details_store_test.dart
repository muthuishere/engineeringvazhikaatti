import 'dart:io';

import 'package:engineeringvazhikaatti/usecases/store/CollegeDetailsStore.dart';
import 'package:test/test.dart';

import '../shared/TestDataGenerator.dart';

void main() {
  test('College Details Store test', () {


    CollegeDetailsStore collegeDetailsStore = TestDataGenerator.getCollegeDetailsStore();
    expect(collegeDetailsStore.collegeDetails.length, 441);
  });
}

