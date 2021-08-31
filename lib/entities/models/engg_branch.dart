import 'year_detail.dart';

class EnggBranch {
    String? code;
    String? name;
    int? count;
    List<YearDetail> history = List.empty();

    EnggBranch({ this.code,  this.name, this.count,  required this.history});

    factory EnggBranch.fromJson(Map<String, dynamic> json) {
        return EnggBranch(
            code: json['code'], 
            name: json['name'],
            count: json['count'],
            history: json['years'] != null ? (json['years'] as List).map((i) => YearDetail.fromJson(i)).toList() : List.empty(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['name'] = this.name;
        data['count'] = this.count;
        if (this.history != null) {
            data['years'] = this.history.map((v) => v.toJson()).toList();
        }
        return data;
    }
}