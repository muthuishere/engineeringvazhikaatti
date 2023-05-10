

import 'package:engineeringvazhikaatti/entities/search_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Search filter can be created manually', () {

    SearchFilter searchFilter = createSearchFilter();
    expect(searchFilter.branchCodes, ["1", "2"]);
    expect(searchFilter.districts, ["1", "2"]);
    expect(searchFilter.message, "message");
    expect(searchFilter.distanceInKms, 1);
    expect(searchFilter.year, 2021);
    expect(searchFilter.searchByDistricts, true);

  });
  test('Search filter copy should create new instance ,old values should not be changed', () {

    SearchFilter searchFilter = createSearchFilter();
    SearchFilter copiedSearchFilter = searchFilter.copy();
    copiedSearchFilter.branchCodes = ["3", "4"];

    expect(searchFilter.branchCodes, ["1", "2"]);
    expect(copiedSearchFilter.branchCodes, ["3", "4"]);
    expect(searchFilter.districts, ["1", "2"]);
    expect(copiedSearchFilter.districts, ["1", "2"]);
    expect(searchFilter.message, "message");
    expect(copiedSearchFilter.message, "message");
    expect(searchFilter.distanceInKms, 1);
    expect(copiedSearchFilter.distanceInKms, 1);
    expect(searchFilter.year, 2021);
    expect(copiedSearchFilter.year, 2021);
    expect(searchFilter.searchByDistricts, true);
    expect(copiedSearchFilter.searchByDistricts, true);

  });

  test('Search filter copyWith should create new instance with newvaluesOnlu ,old values should not be changed', () {

    SearchFilter searchFilter = createSearchFilter();
    SearchFilter copiedSearchFilter = searchFilter.copyWith(branchCodes: ["3", "4"]);

    expect(searchFilter.branchCodes, ["1", "2"]);
    expect(copiedSearchFilter.branchCodes, ["3", "4"]);
    expect(searchFilter.districts, ["1", "2"]);
    expect(copiedSearchFilter.districts, ["1", "2"]);
    expect(searchFilter.message, "message");
    expect(copiedSearchFilter.message, "message");
    expect(searchFilter.distanceInKms, 1);
    expect(copiedSearchFilter.distanceInKms, 1);
    expect(searchFilter.year, 2021);
    expect(copiedSearchFilter.year, 2021);
    expect(searchFilter.searchByDistricts, true);
    expect(copiedSearchFilter.searchByDistricts, true);

  });
}

SearchFilter createSearchFilter() {
     var searchFilter = SearchFilter();
  searchFilter.branchCodes = ["1", "2"];
  searchFilter.districts = ["1", "2"];
  searchFilter.message = "message";
  searchFilter.distanceInKms = 1;
  searchFilter.year = 2021;
  searchFilter.searchByDistricts = true;
  return searchFilter;
}