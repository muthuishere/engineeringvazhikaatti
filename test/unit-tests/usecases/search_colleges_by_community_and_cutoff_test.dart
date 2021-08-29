import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:test/test.dart';

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
}