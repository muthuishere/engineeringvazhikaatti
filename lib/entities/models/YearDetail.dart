import 'package:engineeringvazhikaatti/entities/models/Caste.dart';

import 'Cutoff.dart';
import 'Rank.dart';

class YearDetail {
    Cutoff? cutoff;
    Rank? rank;
    int? year;

    YearDetail({this.cutoff, this.rank, this.year});

    factory YearDetail.fromJson(Map<String, dynamic> json) {
        return YearDetail(
            cutoff: json['cutoff'] != null ? Cutoff.fromJson(json['cutoff']) : null, 
            rank: json['rank'] != null ? Rank.fromJson(json['rank']) : null, 
            year: json['year'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['year'] = this.year;
        if (this.cutoff != null) {
            data['cutoff'] = this.cutoff?.toJson();
        }
        if (this.rank != null) {
            data['rank'] = this.rank?.toJson();
        }
        return data;
    }

 bool isCutOffEnoughForCommunityGroup( double actualCutOff ,CommunityGroup communityGroup) {
        double cutOffForCommunityGroup = cutoff!.markFor(communityGroup);
        return actualCutOff > cutOffForCommunityGroup;

  }
  double rankFor(CommunityGroup communityGroup) {
        return rank!.rankFor(communityGroup);
  }
  double cutOffFor(CommunityGroup communityGroup) {
        return cutoff!.markFor(communityGroup);
  }
}