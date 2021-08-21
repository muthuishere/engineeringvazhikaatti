import 'dart:collection';

import 'package:engineeringvazhikaatti/shared/Convert.dart';

import 'Caste.dart';

class Rank {
    int? bc;
    int? bcm;
    int? mbc;
    int? oc;
    int? sc;
    int? sca;
    int? st;
    HashMap values = new HashMap<CommunityGroup,int>();

    Rank({this.bc, this.bcm, this.mbc, this.oc, this.sc, this.sca, this.st}){
        values[CommunityGroup.BC] = this.bc;
        values[CommunityGroup.BCM] = this.bcm;
        values[CommunityGroup.MBC] = this.mbc;
        values[CommunityGroup.OC] = this.oc;
        values[CommunityGroup.SC] = this.sc;
        values[CommunityGroup.SCA] = this.sca;
        values[CommunityGroup.ST] = this.st;
    }

    factory Rank.fromJson(Map<String, dynamic> json) {
        var toInt= (String prop) { return Convert.toInt(json[prop]); } ;

        return Rank(
            bc: toInt('BC'),
            bcm: toInt('BCM'),
            mbc: toInt('MBC'),
            oc: toInt('OC'),
            sc: toInt('SC'),
            sca: toInt('SCA'),
            st: toInt('ST'),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['BC'] = this.bc;
        data['BCM'] = this.bcm;
        data['MBC'] = this.mbc;
        data['OC'] = this.oc;
        data['SC'] = this.sc;
        data['SCA'] = this.sca;
        data['ST'] = this.st;
        return data;
    }
    double rankFor(CommunityGroup communityGroup){
        return values[communityGroup];
    }
}