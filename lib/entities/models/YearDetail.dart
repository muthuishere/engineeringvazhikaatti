import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/shared/Convert.dart';

import 'Cutoff.dart';
import 'Rank.dart';

class YearDetail {
    Cutoff? cutoff;
    Rank? rank;
    int? year;
    int? branchRank;
    double?  maxcutoff;

    YearDetail({this.cutoff, this.rank, this.year,this.branchRank,this.maxcutoff});

    factory YearDetail.fromJson(Map<String, dynamic> json) {
        return YearDetail(
            cutoff: json['cutoff'] != null ? Cutoff.fromJson(json['cutoff']) : null, 
            rank: json['rank'] != null ? Rank.fromJson(json['rank']) : null, 
            year: json['year'],
          branchRank: Convert.toInt(json['branchRank']),
          maxcutoff: Convert.toDouble(json['maxcutoff']),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['year'] = this.year;
        data['branchRank'] = this.branchRank;
        data['maxcutoff'] = this.maxcutoff;
        if (this.cutoff != null) {
            data['cutoff'] = this.cutoff?.toJson();
        }
        if (this.rank != null) {
            data['rank'] = this.rank?.toJson();
        }
        return data;
    }

 bool isCutOffEnoughForCommunityGroup( double actualCutOff ,CommunityGroup communityGroup) {
        double? cutOffForCommunityGroup = cutoff!.markFor(communityGroup);
        return null == cutOffForCommunityGroup || actualCutOff > cutOffForCommunityGroup;

  }
  int? rankFor(CommunityGroup communityGroup) {
        return rank!.rankFor(communityGroup);
  }
  double? cutOffFor(CommunityGroup communityGroup) {
        return cutoff!.markFor(communityGroup);
  }
}