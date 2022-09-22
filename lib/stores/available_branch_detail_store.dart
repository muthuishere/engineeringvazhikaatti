import 'dart:async';

import 'package:collection/collection.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/models/request/college_with_branch.dart';
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/stores/settings_store.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/models/response/branch_with_college.dart';
import '../entities/search_filter.dart';
import '../entities/settings.dart';
import 'app_config_store.dart';
import 'location_store.dart';

class AvailableBranchDetailStore with  UiLoggy {
// will hold all the results
// will listen from search_filter_store
// if there is changes there, it will update the results

  BehaviorSubject<ListContainer<BranchWithCollege>> _subject =
      new BehaviorSubject<ListContainer<BranchWithCollege>>();

  SearchFilterStore searchFilterStore;
  AppConfigStore appConfigStore;
  SettingsStore settingsStore;
  late StreamSubscription _subscription;
  late LocationStore locationStore;

  AvailableBranchDetailStore(
      {required this.locationStore,
      required this.settingsStore,
      required this.searchFilterStore,
      required this.appConfigStore}) {
    _subject.sink.add(ListContainer.withError<BranchWithCollege>(
        "Please Select District/Distance to continue!!"));
// write a testcase to verify two behavioursubject changes
    _subscription = Rx.combineLatest2(
            this.searchFilterStore.listener(), this.settingsStore.listener(),
            (SearchFilter a, Settings b) => SearchFilterAndSettings(a, b))
        .doOnData((evt) => sendLoading())
        .debounceTime(Duration(milliseconds: 500))
        .map((event) => search(event.searchFilter, event.settings))
        .doOnData((event) => sendData(event))
        .listen(null);
  }
  List<BranchWithCollege> toBranchDetailsFromCollege(CollegeWithBranch college,CommunityGroup communityGroup,
      int year) {
    return college.branches
        .map((branchWithCutoff) => BranchWithCollege.fromCollegeDetailWithBranches(college, branchWithCutoff, communityGroup, year))
        .toList();
  }

  List<BranchWithCollege> toBranchDetailsFromColleges(
      List<CollegeWithBranch> allCollegeDetailWithBranches,
      CommunityGroup communityGroup,
      int year) {
    return allCollegeDetailWithBranches
        .map((college) => toBranchDetailsFromCollege(college, communityGroup, year))
        .expand((element) => element)
        .toList();
  }

  List<BranchWithCollege> search(SearchFilter searchFilter, Settings settings) {


      bool Function(BranchWithCollege) cutoffWithinRange = (branch) =>branch.cutoff <= settings.getCutOff();


    logInfo("search.login() searchFilter.searchByDistricts"+searchFilter.toString());



    return appConfigStore.getAllCollegeDetailWithBranches()
            .where((college) => collegesBasedOn(searchFilter,college))
            .map((college) =>  toBranchDetailsFromCollege(college, settings.communityGroup, searchFilter.year))
            .expand((element) => element)
            .where((element)=>branchesBasedOn(searchFilter,element))
            .where(cutoffWithinRange)
            .sorted((a, b) => b.cutoff.compareTo(a.cutoff))
            .toList();


  }

  bool branchesBasedOn(SearchFilter searchFilter,BranchWithCollege branchWithCollege) {
         bool Function(BranchWithCollege)  isBranchAvailable =(element) => searchFilter.branchCodes.contains(element.code);
    bool Function(BranchWithCollege) allBranchesSelected = (element) => true;
    bool Function(BranchWithCollege) filterByBranch = searchFilter.branchCodes.length>0 ? isBranchAvailable : allBranchesSelected;

    return filterByBranch(branchWithCollege);
  }

  bool collegesBasedOn(SearchFilter searchFilter,CollegeWithBranch college) {
    // loggy.info("collegesBasedOn searchFilter " + searchFilter.toString());
    // loggy.info("collegesBasedOn college " + college.toString());


    bool Function(CollegeWithBranch) collegeInDistrict = (CollegeWithBranch college) => college.withinAnyOfDistricts(searchFilter.districts);
    bool Function(CollegeWithBranch) collegeWithInDistance = (college) => locationStore.withinDistance(college.location, searchFilter.distanceInKms);
    bool Function(CollegeWithBranch) searchCollegesWithin = searchFilter.searchByDistricts? collegeInDistrict: collegeWithInDistance;

    var result = searchCollegesWithin(college);
    // loggy.info("collegesBasedOn college " + college.district + " result " + result.toString());
    return result;
  }

  sendData(List<BranchWithCollege> contents) {
    loggy.info("sendData() contents.length" + contents.length.toString());
    var fromData = ListContainer.fromData<BranchWithCollege>(contents);

    _subject.sink.add(fromData);
  }

  void sendLoading() {
    var fromData = ListContainer.fromLoading<BranchWithCollege>();

    _subject.sink.add(fromData);
  }

  dispose() {
    _subject.close();
    _subscription.cancel();
  }

  BehaviorSubject<ListContainer<BranchWithCollege>> data() {
    return _subject;
  }
  Stream<ListContainer<BranchWithCollege>> stream() {
    return _subject.stream;
  }

  void sendError(String s) {
    var fromData = ListContainer.withError<BranchWithCollege>(s);

    _subject.sink.add(fromData);
  }

  List<BranchWithCollege> getAllBranchesIn(BranchWithCollege input,int year) {

    return appConfigStore.getAllCollegeDetailWithBranches()
        .where((college) => college.code == input.collegeDetail.code)
        .map((college) =>  toBranchDetailsFromCollege(college, this.settingsStore.getSettings().communityGroup, year))
        .expand((element) => element)
        .where((branchDetail)=>branchDetail.code != input.code)
        .toList();


  }
}

class SearchFilterAndSettings {
  final SearchFilter searchFilter;
  final Settings settings;

  SearchFilterAndSettings(this.searchFilter, this.settings);

  operator [](int index) {
    if (index == 0) {
      return searchFilter;
    } else if (index == 1) {
      return settings;
    } else {
      throw Exception("Index out of bounds");
    }
  }
}
