import '../entities/user/UserProfile.dart';
import 'package:engineeringvazhikaatti/mark.dart';
import 'package:rxdart/rxdart.dart';

class UpdateProfile{

  var profile =UserProfile(physics: 70.0, chemistry:70.0, maths: 70.0);
  
  UserProfile getProfile(){
    return profile;
  }
  void setProfile(double physics,double chemistry,double maths){

    profile.setData(physics, chemistry, maths);
  }
}

