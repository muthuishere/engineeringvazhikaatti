
import 'package:rxdart/rxdart.dart';

import '../entities/search_filter.dart';

class SearchFilterStore {

  BehaviorSubject<SearchFilter> _searchFilterObserver =
      BehaviorSubject<SearchFilter>.seeded(SearchFilter());


  String filterMessageForDistricts(List<String> branchCodes,
      List<String> districts) {
    return "Searching on " +
        branchCodes.length.toString() +
        " branches &  " +
        districts.length.toString() +       " districts ";

  }



  notify(SearchFilter input){
    // input.generateMessage();
    _searchFilterObserver.sink.add(input);
  }

  toggle() {
    var toggledSearchByDistricts = !getSearchFilter().searchByDistricts;
    notify(getSearchFilter().copyWith(searchByDistricts:toggledSearchByDistricts ));
  }


  getSearchFilter(){
    return _searchFilterObserver.value;
  }



  dispose(){
    _searchFilterObserver.close();
  }




  void setDistanceInKms(value) {

    notify(getSearchFilter().copyWith(distanceInKms:value ));
  }

  void setYear(value) {

    notify(getSearchFilter().copyWith(year:value ));
  }

  void setSearchByDistricts(value) {

    notify(getSearchFilter().copyWith(searchByDistricts:value ));
  }
  void setSearchMessage(value) {

    notify(getSearchFilter().copyWith(message:value ));
  }

  void reload() {
    notify(getSearchFilter().copy());
  }

  bool hasDistrictsSelected(){
    return getSearchFilter().districts.isNotEmpty;
  }

  bool hasDistanceInKmsSelected(){
    return getSearchFilter().distanceInKms! > 5;
  }


  Stream<SearchFilter>  listener(){
    return _searchFilterObserver.stream;
  }

  void updateWith(SearchFilter searchFilter) {
    notify(searchFilter);
  }



}
