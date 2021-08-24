import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';

class CollegeDetailsStore{

  List<CollegeDetail> _collegeDetails= List.empty();

  List<CollegeDetail> _from(String contents){
    Iterable iterableContents = json.decode(contents);
    var items = iterableContents.map((content)=> CollegeDetail.fromJson(content));
    return List<CollegeDetail>.from(items);
  }

  List<CollegeDetail> get collegeDetails {
    return _collegeDetails;
  }


  load(String contents){
    this._collegeDetails=_from(contents);

  }

}