import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/available_colleges_response.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/filter.dart';
import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:rxdart/rxdart.dart';

class SearchFilterStore {

  bool searchByDistrictsEnabled = true;
  var searchFilter =Filter();
  String searchMsg ="";
  BehaviorSubject<bool> _searchByDistricts =
      new BehaviorSubject<bool>();


  toggle() {
    searchByDistrictsEnabled=!searchByDistrictsEnabled;

    _searchByDistricts.sink.add(searchByDistrictsEnabled);
  }




  dispose(){
    _searchByDistricts.close();
  }
  SearchFilterStore() {
    _searchByDistricts.sink.add(searchByDistrictsEnabled);
  }

  BehaviorSubject<bool>  searchByDistrictChanges(){

    return _searchByDistricts;
  }

  void send(Filter searchFilter) {
    this.searchFilter=searchFilter;
  }

  void setDistanceInKms(value) {
    searchFilter.distanceInKms=value;
  }

  void setSearchByDistricts(value) {
    searchByDistrictsEnabled=value;

  }

  bool hasDistrictsSelected(){
    return this.searchFilter.districts.isNotEmpty;
  }

  bool hasDistanceInKmsSelected(){
    return this.searchFilter.distanceInKms! > 5;
  }





}
