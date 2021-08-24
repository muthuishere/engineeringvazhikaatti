import 'package:engineeringvazhikaatti/entities/models/YearDetail.dart';
import 'package:json_annotation/json_annotation.dart';

import 'AvailableYearDetail.dart';

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

@JsonSerializable()
class AvailableBranch {
  String? code;
  String? name;
  List<AvailableYearDetail> yearDetails = List.empty();
  late AvailableYearDetail? currentYear = null;

  AvailableBranch(this.code, this.name, this.yearDetails) {
    sortYears();
  }

  AvailableBranch.from({this.code, this.name, required this.yearDetails}) {
    sortYears();
  }

  factory AvailableBranch.fromJson(Map<String, dynamic> json) {
    return AvailableBranch.from(
      code: json['code'],
      name: json['name'],
      yearDetails: json['yearDetails'] != null
          ? (json['yearDetails'] as List)
              .map((i) => AvailableYearDetail.fromJson(i))
              .toList()
          : List.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.yearDetails != null) {
      data['yearDetails'] = this.yearDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }

  isValidBranch() {
    return null != currentYear;
  }

  int getRank() {
    int? response = currentYear?.branchRank!;
    return null == response ? 9999 : response;
  }

  void sortYears() {
    this.yearDetails.sort((a, b) {
      //Ascending
      // return a.year!.compareTo(b.year!);
      //Descending
      return b.year!.compareTo(a.year!);
    });

    if (this.yearDetails.isNotEmpty) this.currentYear = this.yearDetails[0];
  }

  getCutOff() {
    return (null != currentYear) ? currentYear?.cutoff! : -1;
  }
}
