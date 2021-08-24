import 'package:engineeringvazhikaatti/entities/Settings.dart';
import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/usecases/SearchColleges.dart';
import 'package:test/test.dart';

import '../../shared/JsonConvert.dart';
import 'shared/TestDataGenerator.dart';

void main() {
  test('Search ByPreferences should work fine', () {
    var appConfigStore = TestDataGenerator.getAppConfigStore();
    var collegeDetailStore = TestDataGenerator.getCollegeDetailsStore();
    var searchColleges = SearchColleges(appConfigStore, collegeDetailStore);
    var userPreferences = TestDataGenerator.getPreferences();
    var results = searchColleges.byBranchAndDistricts(userPreferences.branchCodes,userPreferences.districts);

    JsonConvert.saveAsFile("byuserpreferences.json", results);

    expect(results.length, 75);
  });
  test('Search ByPreferencesandprofile should work fine', () {
    var appConfigStore = TestDataGenerator.getAppConfigStore();
    var collegeDetailStore = TestDataGenerator.getCollegeDetailsStore();
    var searchColleges = SearchColleges(appConfigStore, collegeDetailStore);
    var userPreferences = TestDataGenerator.getPreferences();
    Settings profile = Settings(physics: 88.21, chemistry: 89.64, maths: 91.83, communityGroup: CommunityGroup.BC);
    var results = searchColleges.byPreferencesAndProfileAndSortDefault(userPreferences,profile);

    results.forEach((element) {
      element.branches!.forEach((branch) {
        print(element.name! + "=> branch=> "+ branch.code! +"=> branch=> "+ branch.getCutOff().toString() + "=> Rank=> " + branch.getRank().toString());
      });
    });
    JsonConvert.saveAsFile("byuserpreferencesandprofile.json", results);

    expect(results.length, 63);
  });
}
