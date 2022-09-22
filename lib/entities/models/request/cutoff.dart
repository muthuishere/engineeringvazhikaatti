import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';

import "../../../shared/convert.dart";

class Cutoff {
    double? bc;
    double? bcm;
    double? mbc;
    double? mbcdnc;
    double? mbcv;
    double? oc;
    double? sc;
    double? sca;
    double? st;


    Cutoff({this.bc,  this.bcm,  this.mbc,required  this.mbcdnc,  this.mbcv,  this.oc,  this.sc,  this.sca,  this.st});

    //BC,BCM,MBC,MBCDNC,MBCV, OC,SC,SCA,ST
    //get cutoff based on community group
    double getCutOff(CommunityGroup communityGroup){
      switch(communityGroup){
        case CommunityGroup.BC:
          return bc ?? 0;
        case CommunityGroup.BCM:
          return bcm ?? 0;
        case CommunityGroup.MBC:
          return mbc ?? 0;
        case CommunityGroup.MBCDNC:
          return mbcdnc ?? 0;
        case CommunityGroup.MBCV:
          return mbcv ?? 0;
        case CommunityGroup.OC:
          return oc ?? 0;
        case CommunityGroup.SC:
          return sc ?? 0;
        case CommunityGroup.SCA:
          return sca ?? 0;
        case CommunityGroup.ST:
          return st ?? 0;
        default:
          return 0;
      }
    }


    factory Cutoff.fromJson(Map<String, dynamic> json) {
        var toDouble = (dynamic s) => null != s?s.toDouble():null;
        return Cutoff(
            bc: toDouble(json['bc']),
            bcm: toDouble(json['bcm']),
            mbc: toDouble(json['mbc']),
            mbcdnc: toDouble(json['mbcdnc']),
            mbcv: toDouble(json['mbcv']),
            oc: toDouble(json['oc']),
            sc: toDouble(json['sc']),
            sca:toDouble( json['sca']),
            st: toDouble(json['st']),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bc'] = this.bc;
        data['bcm'] = this.bcm;
        data['mbc'] = this.mbc;
        data['mbcdnc'] = this.mbcdnc;
        data['mbcv'] = this.mbcv;
        data['oc'] = this.oc;
        data['sc'] = this.sc;
        data['sca'] = this.sca;
        data['st'] = this.st;
        return data;
    }
}