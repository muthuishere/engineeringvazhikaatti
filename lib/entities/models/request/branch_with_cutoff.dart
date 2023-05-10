

import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';

import 'cutoff.dart';
import 'cutoff_by_year.dart';
import '../../../shared/Iterable_extension.dart';

class BranchWithCutoff {
    String code;
    List<CutoffByYear>? cutoffs;
    String name;

    BranchWithCutoff({required this.code, required this.cutoffs, required this.name});

    factory BranchWithCutoff.fromJson(Map<String, dynamic> json) {
        return BranchWithCutoff(
            code: json['code'], 
            cutoffs: json['cutoffs'] != null ? (json['cutoffs'] as List).map((i) => CutoffByYear.fromJson(i)).toList() : null,
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['name'] = this.name;
        final cutoffs = this.cutoffs;
        if (cutoffs != null) {
            data['cutoffs'] = cutoffs.map((v) => v.toJson()).toList();
        }
        return data;
    }

    Map<int, double> cutOffsForCommunity(CommunityGroup communityGroup) {

        return cutoffs?.map((e) => MapEntry(e.year, e.cutoff?.getCutOff(communityGroup) ?? 0.0))?.toMap() ?? {};

    }
    double getCutoffForYearAndCommunity(int year, CommunityGroup communityGroup) {
        double currentYearCutOff = cutoffs
            ?.where((element) => element.year == year)
            .map((e) => e.cutoff?.getCutOff(communityGroup))
            .first ??0.0;
        return currentYearCutOff;
    }
}