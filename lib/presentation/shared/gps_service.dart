import 'dart:convert';

import 'package:engineeringvazhikaatti/entities/available_colleges_response.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/filter.dart';
import 'package:engineeringvazhikaatti/entities/models/college_detail.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/presentation/shared/gps_status.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class GpsService {

  BehaviorSubject<GpsStatus> _gpsStatusObservable =
      new BehaviorSubject<GpsStatus>.seeded(GpsStatus.NO_STATUS);

  Position? position=null;
  getStatus(){
    return _gpsStatusObservable;
  }




  set(GpsStatus gpsStatus) {


    _gpsStatusObservable.sink.add(gpsStatus);
  }




  dispose(){
    _gpsStatusObservable.close();
  }


  BehaviorSubject<GpsStatus>  searchByDistrictChanges(){

    return _gpsStatusObservable;
  }


  Future<Position> retrieveLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    set(GpsStatus.LOADING);
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      set(GpsStatus.ERROR);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        set(GpsStatus.ERROR);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      set(GpsStatus.ERROR);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition();
    set(GpsStatus.COMPLETED);
    return position;
  }



  static final GpsService _singleton = GpsService._internal();

  factory GpsService() {

    return _singleton;
  }

  GpsService._internal();



}
