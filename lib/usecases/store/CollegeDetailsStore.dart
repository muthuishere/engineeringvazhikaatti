import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/models/CollegeDetail.dart';

class CollegeDetailsStore{

  List<CollegeDetail> collegeDetails= List.empty();

  List<CollegeDetail> from(String contents){
    Iterable iterableContents = json.decode(contents);
    var items = iterableContents.map((content)=> CollegeDetail.fromJson(content));
    return List<CollegeDetail>.from(items);
  }

  load(String contents){
    this.collegeDetails=from(contents);

  }
}