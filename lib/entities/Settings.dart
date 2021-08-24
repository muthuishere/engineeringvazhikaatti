import 'dart:ffi';
import 'package:engineeringvazhikaatti/entities/models/Caste.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Settings {
  double physics;
  double chemistry;
  double maths;
  CommunityGroup communityGroup;

  Settings({
    required this.physics,
    required this.chemistry,
    required this.maths,
    required this.communityGroup,
  });

  @override
  List<Object> get props => [physics, chemistry, maths, communityGroup];

  void set(double physics, double chemistry, double maths ,[CommunityGroup? community]) {
    this.physics = physics;
    this.chemistry = chemistry;
    this.maths = maths;
    if(null != community)
      this.communityGroup=community;

  }

  double getCutOff() {
    return (this.physics / 2) + (this.chemistry / 2) + this.maths;
  }
}
