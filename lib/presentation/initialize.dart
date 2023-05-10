import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import '../stores/location_store.dart';
import 'gps/gps_service.dart';
import 'gps/gps_status.dart';

class Initialize extends StatelessWidget {

  late final DashboardApi? dashboardApi;
  late final LocationStore locationUpdater;
  late final AppNotification appNotification;
  late final  GpsService gpsService;
  late final SearchFilterStore searchFilterStore;

  Initialize({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;

    searchFilterStore = injector.get<SearchFilterStore>();
    locationUpdater = injector.get<LocationStore>();
     gpsService = GpsService();
  }

  final String title = "Initializing";

  //
  // @override
  // _DashboardState createState() => _DashboardState();

  void reload() {
    searchFilterStore.reload();
  }

  void updateGps(BuildContext context) {
    gpsService.retrieveLocation().then((position) {
      locationUpdater.setLocation(position.latitude, position.longitude);
      Navigator.pushReplacementNamed(context, '/home');
    }).catchError((msg) {
      appNotification.showError(msg);

    });
  }

  Widget gpsProgress(BuildContext context) {
    return StreamBuilder<GpsStatus>(
        stream: gpsService.getStatus().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! == GpsStatus.LOADING) {
              return Container(
                child: LinearProgressIndicator(),
              );
            }else if (snapshot.data! == GpsStatus.ERROR) {
              return Container(
                child: Text("Gps Error, Click the location icon again")
              );
            }
          }
          return Text("");
        });
  }

  static bool initialized=false;
  @override
  Widget build(BuildContext context) {
    if(initialized == false){
      initialized=true;
      updateGps(context);

    }
    appNotification = AppNotification(context);


    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the Dashboard object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
          leading: new IconButton(
            icon: new Icon(Icons.location_on),
            onPressed: () {
              updateGps(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Cut Off And Community Data',
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            IconButton(
              icon: const Icon(Icons.help_outline_rounded),
              tooltip: 'Whats This?',
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            gpsProgress(context),
          ],
        )),
       );
  }


}
