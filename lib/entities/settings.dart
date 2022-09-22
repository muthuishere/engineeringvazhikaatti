

import 'package:engineeringvazhikaatti/stores/AppDefaultConfig.dart';
import 'package:loggy/loggy.dart';

import 'cutoffstatus.dart';
import 'models/request/community_group.dart';

class Settings with UiLoggy{
  double physics;
  double chemistry;
  double maths;
  CommunityGroup communityGroup;

  Settings(
      {required this.physics,
      required this.chemistry,
      required this.maths,
      required this.communityGroup});

  @override
  List<Object> get props => [physics, chemistry, maths, communityGroup];

  void set(double physics, double chemistry, double maths,
      CommunityGroup community) {
    this.physics = physics;
    this.chemistry = chemistry;
    this.maths = maths;

    this.communityGroup = community;
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
        physics: json['physics'],
        chemistry: json['chemistry'],
        maths: json['maths'],
        communityGroup: CommunityGroup.values[json['communityGroup']]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['physics'] = this.physics;
    data['chemistry'] = this.chemistry;
    data['maths'] = this.maths;
    data['communityGroup'] = this.communityGroup.index;
    return data;
  }

  double getCutOff() {
    return (this.physics / 2) + (this.chemistry / 2) + this.maths;
  }


  CutoffStatus getCutOffStatusWith(double input){
    var difference =  getCutOff() - input;

    int lowestRange = AppDefaultConfig.getAllowedRange() * -1;
    int highestRange = AppDefaultConfig.getAllowedRange() ;
    // logInfo("difference is $difference");
    if(difference < lowestRange)
      return CutoffStatus.RED;
    else if(difference >= lowestRange && difference <= highestRange)
      return CutoffStatus.YELLOW;
    else
      return CutoffStatus.GREEN;
  }

}
