import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/available_colleges_response.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:rxdart/rxdart.dart';

class AvailableCollegesStore {


  BehaviorSubject<ListContainer<AvailableCollege>> _subject =
      new BehaviorSubject<ListContainer<AvailableCollege>>();

  send(List<AvailableCollege> contents) {

    var fromData = ListContainer.fromData<AvailableCollege>(contents);

    _subject.sink.add(fromData);
  }
  void showLoading() {
    _subject.sink.add(ListContainer<AvailableCollege>());
  }

  dispose(){
    _subject.close();
  }
  AvailableCollegesStore() {
    _subject.sink.add(ListContainer.fromData<AvailableCollege>([]));
  }

  BehaviorSubject<ListContainer<AvailableCollege>>  data(){

    return _subject;
  }



  void showError(String s) {
    var fromData = ListContainer.fromError<AvailableCollege>(s);

    _subject.sink.add(fromData);
  }



}
