import 'dart:convert';
import 'dart:io';

import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';
import 'package:test/test.dart';


void main() {
  test('College Detail should load from JSON and be valid', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    expect(collegeDetail.name, "University Departments of Anna University");
    expect(collegeDetail.id, 1);
    expect(collegeDetail.branches?.length, 17);
    print(collegeDetail.toJson());
  });

  test('sameDistrictAndBranch should return true for same district and Branch', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    List<String> districts=["villupuram","Chennai"];
    List<String> branchCodes=["CE","MI"];

    expect(collegeDetail.sameDistrictAndBranch(districts, branchCodes),true);
  });
  test('sameDistrictAndBranch should return false for different district', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    List<String> districts=["villupuram","madurai"];
    List<String> branchCodes=["CE","MI"];

    expect(collegeDetail.sameDistrictAndBranch(districts, branchCodes),false);
  });
  test('sameDistrictAndBranch should return false for different Branch', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    List<String> districts=["villupuram","madurai","Chennai"];
    List<String> branchCodes=["LUII"];

    expect(collegeDetail.sameDistrictAndBranch(districts, branchCodes),false);
  });
  test('sameDistrictAndBranch should return true  if district exists and no Branch specified', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    List<String> districts=["villupuram","madurai","Chennai"];
    List<String> branchCodes=[];

    expect(collegeDetail.sameDistrictAndBranch(districts, branchCodes),true);
  });

  test('sameDistrictAndBranch should return true  if branch exists and no district specified', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    List<String> districts=[];
    List<String> branchCodes=["CE"];

    expect(collegeDetail.sameDistrictAndBranch(districts, branchCodes),true);
  });

  test('sameDistrictAndBranch should return true  if everything is empty', () {
    CollegeDetail collegeDetail = getCollegeDetail();

    List<String> districts=[];
    List<String> branchCodes=[];

    expect(collegeDetail.sameDistrictAndBranch(districts, branchCodes),true);
  });


}

CollegeDetail getCollegeDetail() {
  var contents = File('testassets/validjson/collegedetail.json').readAsStringSync();
  Map<String, dynamic> userMap = jsonDecode(contents);
  var collegeDetail = CollegeDetail.fromJson(userMap);
  return collegeDetail;
}