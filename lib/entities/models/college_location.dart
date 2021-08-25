import 'package:engineeringvazhikaatti/adapters/distance_calculator.dart';
import 'package:engineeringvazhikaatti/shared/convert.dart';


class CollegeLocation {
    double? latitude;
    double? longitude;

    CollegeLocation({this.latitude, this.longitude});

    factory CollegeLocation.fromJson(Map<String, dynamic> json) {
        var toDouble = (String prop) { return Convert.toDouble(json[prop]); } ;

        return CollegeLocation(
            latitude: toDouble('latitude'),
            longitude: toDouble('longitude'),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['latitude'] = this.latitude;
        data['longitude'] = this.longitude;
        return data;
    }

    bool hasLocation(){
        return null != longitude && null != latitude;
    }




}