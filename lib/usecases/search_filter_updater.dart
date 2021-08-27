
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:flutter/cupertino.dart';

import '../entities/filter.dart';

class SearchFilterUpdater{

  var searchFilter =Filter();
  late SearchFilterStore searchFilterStore;

  Filter getPreferences(){
    return searchFilter;
  }
  void setBranchCodes(List<String> branchCodes){
    searchFilter.setBranchCodes(branchCodes);
    this.searchFilterStore.send(searchFilter);
  }
  void setDistricts(List<String> districts){
    searchFilter.setDistricts(districts);
    this.searchFilterStore.send(searchFilter);
  }
  void updatePreferences(List<String> branches,List<String> districts){
    setDistricts(districts);
    setBranchCodes(branches);
    this.searchFilterStore.send(searchFilter);
  }

  void toggle(){
    this.searchFilterStore.toggle();
  }

  SearchFilterUpdater(this.searchFilterStore);
}