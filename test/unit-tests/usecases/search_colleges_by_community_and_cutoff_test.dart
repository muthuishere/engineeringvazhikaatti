import 'package:engineeringvazhikaatti/entities/models/response/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:engineeringvazhikaatti/usecases/sort_colleges.dart';
import 'package:test/test.dart';

import '../../shared/JsonConvert.dart';
import '../entities/results/available_college_test.dart';
import '../../shared/TestDataGenerator.dart';

void main() {
  test('Test Within Area', () {
    var collegeDetailsStore =TestDataGenerator.getCollegeDetailsStore();


    var searchCollegesByCommunityAndCutoff = SearchCollegesByCommunityAndCutoff(collegeDetailsStore,TestDataGenerator.getDistanceCalculator());

    CollegeDetail collegeDetail = TestDataGenerator.getMockedCollegeDetail();
    var lat = 13.0532;
    var lon = 80.1922;
    //double kms, CollegeDetail element, double lat2, double lon2
    expect(searchCollegesByCommunityAndCutoff.within(25,collegeDetail,lat, lon), true);
  });

  test('Test All Cs Excel Area', () {
    var collegeDetailsStore =TestDataGenerator.getCollegeDetailsStore();

    var searchCollegesByCommunityAndCutoff = SearchCollegesByCommunityAndCutoff(collegeDetailsStore,TestDataGenerator.getDistanceCalculator());

    CollegeDetail collegeDetail = TestDataGenerator.getMockedCollegeDetail();
    var lat = 13.0532;
    var lon = 80.1922;
    //double kms, CollegeDetail element, double lat2, double lon2
    var within = searchCollegesByCommunityAndCutoff.within(25000,collegeDetail,lat, lon);
    expect(within, true);
  });
  test('Test Get Data', () {

    var collegeDetailsStore =TestDataGenerator.getCollegeDetailsStore();

    var searchCollegesByCommunityAndCutoff = SearchCollegesByCommunityAndCutoff(collegeDetailsStore,TestDataGenerator.getDistanceCalculator());

    CollegeDetail collegeDetail = TestDataGenerator.getMockedCollegeDetail();


    var distanceCalculator =TestDataGenerator.getDistanceCalculator();
    var _sortColleges =SortColleges(distanceCalculator);

    var results = searchCollegesByCommunityAndCutoff.getDataBasedOn(_sortColleges,['CS', 'IT',"CM","IM","AM","BD","AD","CB","RM","CO","AL","CY","TS","CT","SC","SB"],200);

    JsonConvert.saveAsFile("results.json", results);
    print(results.toString());


    });
}