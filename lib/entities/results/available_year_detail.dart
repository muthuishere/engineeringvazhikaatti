


import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AvailableYearDetail {
    double? cutoff;
    int? rank;
    int? year;
    int? branchRank;


    AvailableYearDetail.from({this.cutoff, this.rank, this.year,this.branchRank}){


    }
    AvailableYearDetail(this.cutoff, this.rank, this.year,this.branchRank){

    }

    factory AvailableYearDetail.fromJson(Map<String, dynamic> json) {
        return AvailableYearDetail.from(
            cutoff: json['cutoff'] != null ? json['cutoff'] : null,
            rank: json['rank'] != null ? json['rank'] : null,
            year: json['year'],
            branchRank: json['branchRank']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['year'] = this.year;
        data['branchRank'] = this.branchRank;
        if (this.cutoff != null) {
            data['cutoff'] = this.cutoff;
        }
        if (this.rank != null) {
            data['rank'] = this.rank;
        }
        return data;
    }

}