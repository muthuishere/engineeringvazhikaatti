import 'dart:collection';

import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:engineeringvazhikaatti/shared/Convert.dart';

class Cutoff {
    double? bc;
    double? bcm;
    double? mbc;
    double? oc;
    double? sc;
    double? sca;
    double? st;

    HashMap values = new HashMap<CommunityGroup,double>();

    Cutoff({this.bc, this.bcm, this.mbc, this.oc, this.sc, this.sca, this.st}){
        values[CommunityGroup.BC] = this.bc;
        values[CommunityGroup.BCM] = this.bcm;
        values[CommunityGroup.MBC] = this.mbc;
        values[CommunityGroup.OC] = this.oc;
        values[CommunityGroup.SC] = this.sc;
        values[CommunityGroup.SCA] = this.sca;
        values[CommunityGroup.ST] = this.st;
    }


    factory Cutoff.fromJson(Map<String, dynamic> json) {
        var toDouble = (String prop) { return Convert.toDouble(json[prop]); } ;

        return Cutoff(
            bc: toDouble('BC'),
            bcm: toDouble('BCM'),//Convert.toDouble(json['BCM']),
            mbc: toDouble('MBC'),//Convert.toDouble(json['MBC']),
            oc: toDouble('OC'),//Convert.toDouble(json['OC']),
            sc: toDouble('SC'),//Convert.toDouble(json['SC']),
            sca: toDouble('SCA'),//Convert.toDouble(json['SCA']),
            st: toDouble('ST'),//Convert.toDouble(json['ST']),
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
    double markFor(CommunityGroup communityGroup){
        return values[communityGroup];
    }
}