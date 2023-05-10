import 'dart:async';
import 'dart:ffi';

import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';

import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/stores/available_branch_detail_store.dart';
import 'package:engineeringvazhikaatti/stores/location_store.dart';
import 'package:engineeringvazhikaatti/stores/settings_store.dart';
import 'package:loggy/loggy.dart';
import 'package:test/test.dart';
import 'package:async/async.dart';


import '../../shared/TestDataGenerator.dart';
import '../../shared/test_initializer.dart';

void main() {


  setUp(() {
    TestInitializer.initLogs();
  });

  test('search within district chennai ,should show colleges only in chennai district', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 100.0,
        chemistry: 100.0,
        maths: 100.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);

    List<BranchWithCollege> results = availableBranchDetailStore.search(TestDataGenerator.getSearchFilterWithDistrictChennai(),settings);
    results.forEach((element) {
      logInfo(element.name   + "[" +  element.collegeDetail.description + "]");
      expect(element.collegeDetail.district, equals("Chennai"));

    });

  });

  test('search within 150 kms from chennai ,should show colleges only in chennai & chengalpattu district', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 100.0,
        chemistry: 100.0,
        maths: 100.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennai();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistrictChennai,settings);
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });

    results.forEach((element) {
      expect(element.collegeDetail.district, isIn(["Chennai","Chengalpattu","Villupuram"]));

    });

  });

  test('searchbydistrict false and distance is null ,should show  all colleges', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 100.0,
        chemistry: 100.0,
        maths: 100.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistanceNull = TestDataGenerator.getSearchFilterWithDistanceNull();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistanceNull,settings);
    expect(results.length, 7);
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });


  });
  test('searchbydistrict false and distance is 200 kms ,should show  colleges around 200 kms', () async {

//searchFilter.searchByDistricts{message: Searching on 1branches on 1 districts, distanceInKms: 50, year: 2021, searchByDistricts: false, branchCodes: CS, districts: Chennai}


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 100.0,
        chemistry: 100.0,
        maths: 100.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistanceNull = TestDataGenerator.getSearchFilterWithDistance200Kms();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistanceNull,settings);
    expect(results.length, 5);
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });


  });
  test('searchbydistrict true and districts  is null or empty ,should show  all colleges', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 100.0,
        chemistry: 100.0,
        maths: 100.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistrictsAndDistrictsEmpty = TestDataGenerator.getSearchFilterWithDistrictsNull();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistrictsAndDistrictsEmpty,settings);
    expect(results.length, 7);
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });


  });

  test('search should return courses with cutoff less than actual one', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 90.0,
        chemistry: 90.0,
        maths: 90.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennai();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistrictChennai,settings);
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.cutoff.toString() + "=>" + element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });

    results.forEach((element) {
      expect(element.cutoff, lessThanOrEqualTo(180.0));
      expect(element.collegeDetail.district, equals("Villupuram"));
    });

  });

  test('search results should be sorted descending', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 90.0,
        chemistry: 90.0,
        maths: 90.0,
        communityGroup: CommunityGroup.BC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennai();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistrictChennai,settings);

    List<double> cutoffs = results.map((e) => e.cutoff).toList();
    logInfo(cutoffs.toString());
    expect(cutoffs, orderedEquals([174.01,172.65,168.58,127.0,0.0]));
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.cutoff.toString() + "=>" + element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });



  });


  test('search results should take community group into consideration', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 90.0,
        chemistry: 90.0,
        maths: 90.0,
        communityGroup: CommunityGroup.MBC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennai();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistrictChennai,settings);

    List<double> cutoffs = results.map((e) => e.cutoff).toList();
    logInfo(cutoffs.toString());
    expect(cutoffs, orderedEquals( [177.495, 168.87, 164.0, 142.925, 0.0, 0.0]));
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.cutoff.toString() + "=>" + element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");

    });



  });

  test('search results should take only selected branches into consideration', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();
    var searchFilterStore = TestDataGenerator.getSearchFilterStore();
    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 90.0,
        chemistry: 90.0,
        maths: 90.0,
        communityGroup: CommunityGroup.MBC);


    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);
    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennaiAndCsBranch();
    List<BranchWithCollege> results = availableBranchDetailStore.search(searchFilterWithDistrictChennai,settings);

    List<double> cutoffs = results.map((e) => e.cutoff).toList();
    logInfo(cutoffs.toString());
    expect(cutoffs, orderedEquals( [177.495]));
    results.forEach((element) {
      logInfo(element.name + "=>"+ element.cutoff.toString() + "=>" + element.collegeDetail.district  + "[" +  element.collegeDetail.description + "]");
      expect(element.code, equals("CS"));
    });



  });

  test('search results should be updated if search filter changed ', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();

    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 90.0,
        chemistry: 90.0,
        maths: 90.0,
        communityGroup: CommunityGroup.MBC);


    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennaiAndCsBranch();
    var searchFilterStore = TestDataGenerator.getSearchFilterStoreWith(searchFilterWithDistrictChennai);
    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);



    searchFilterStore.setYear(2020);

    var events = StreamQueue<ListContainer<BranchWithCollege>>( availableBranchDetailStore.stream().timeout(const Duration(seconds: 1)));;
    var first = await events.next;
    logInfo(first.toString());
    expect(first.dataStatus, DataStatus.ERROR);
    expect(first.message, "Please Select District/Distance to continue!!");

    var second = await events.next;
    logInfo("second" + second.toString());
    expect(second.dataStatus, DataStatus.LOADING);
    //
    // var third = await events.next;
    // logInfo("third" + third.toString());
    // expect(third.dataStatus, DataStatus.SUCCESS);

    var fourth = await events.next;
    logInfo("fourth" + fourth.toString());
    expect(fourth.dataStatus, DataStatus.LOADING);


    var fifth = await events.next;
    logInfo("fifth" + fifth.toString());
    expect(fifth.dataStatus, DataStatus.SUCCESS);

    expect(() async => await events.next, throwsA(TypeMatcher<TimeoutException>()));

  });
  test('search results should emits in order ', () async {


    var appConfigStore = TestDataGenerator.getMockedAppConfigStore();

    LocationStore locationStore = TestDataGenerator.getLocationStoreForVirugambakkam();
    var settings=  Settings(
        physics: 90.0,
        chemistry: 90.0,
        maths: 90.0,
        communityGroup: CommunityGroup.MBC);


    var searchFilterWithDistrictChennai = TestDataGenerator.getSearchFilterWithin150KmsAroundChennaiAndCsBranch();
    var searchFilterStore = TestDataGenerator.getSearchFilterStoreWith(searchFilterWithDistrictChennai);
    SettingsStore settingsStore = await TestDataGenerator.getSettingsStoreWith(settings);
    var availableBranchDetailStore = AvailableBranchDetailStore(locationStore:locationStore,settingsStore:settingsStore,appConfigStore:appConfigStore ,searchFilterStore: searchFilterStore);



    searchFilterStore.setYear(2020);

    expect( availableBranchDetailStore.stream(), emitsInOrder([
      HasStatus(DataStatus.ERROR),
      HasStatus(DataStatus.LOADING),
      HasStatus(DataStatus.LOADING),
      HasStatus(DataStatus.SUCCESS)
    ]
    ));


  });


}


class HasStatus extends CustomMatcher {
  HasStatus(matcher) : super("ListContainer status", "price", matcher);
   featureValueOf(actual) => (actual as ListContainer).dataStatus;
 }