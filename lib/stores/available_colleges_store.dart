
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:rxdart/rxdart.dart';

class AvailableCollegesStore {


  BehaviorSubject<ListContainer<AvailableCollege>> _subject =
      new BehaviorSubject<ListContainer<AvailableCollege>>();

  sendData(List<AvailableCollege> contents) {

    var fromData = ListContainer.fromData<AvailableCollege>(contents);

    _subject.sink.add(fromData);
  }
  void sendLoading() {
    var fromData = ListContainer.fromLoading<AvailableCollege>();

    _subject.sink.add(fromData);
  }

  dispose(){
    _subject.close();
  }
  AvailableCollegesStore() {
    _subject.sink.add(ListContainer.fromMessage<AvailableCollege>("Please Select District/Distance to continue!!"));
  }

  BehaviorSubject<ListContainer<AvailableCollege>>  data(){

    return _subject;
  }



  void sendMessage(String s) {
    var fromData = ListContainer.fromMessage<AvailableCollege>(s);

    _subject.sink.add(fromData);
  }



}
