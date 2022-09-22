import 'cutoff.dart';

class CutoffByYear {
    Cutoff? cutoff;
    int year;

    CutoffByYear({this.cutoff, required this.year});

    factory CutoffByYear.fromJson(Map<String, dynamic> json) {
        return CutoffByYear(
            cutoff: null ==json['cutOff'] ?null: Cutoff.fromJson(json['cutOff']) ,
            year: json['year'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['year'] = this.year;
        if (this.cutoff != null) {
            data['cutOff'] = this.cutoff?.toJson();
        }
        return data;
    }
}