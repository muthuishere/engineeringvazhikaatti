import 'package:engineeringvazhikaatti/entities/containers/data_container.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/results/available_branch.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/presentation/shared/gps_status.dart';
import 'package:engineeringvazhikaatti/presentation/shared/gps_service.dart';
import 'package:engineeringvazhikaatti/presentation/shared/text_styles.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';

import 'filter_panel.dart';

class Initialize extends StatelessWidget {
  late final AvailableCollegesStore? availableCollegesStore;
  late final DashboardApi? dashboardApi;
  late final LocationUpdater? locationUpdater;
  late final AppNotification appNotification;
  late final  GpsService gpsService;


  Initialize({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    availableCollegesStore = injector.get<AvailableCollegesStore>();
    dashboardApi = injector.get<DashboardApi>();
    locationUpdater = injector.get<LocationUpdater>();
     gpsService = GpsService();
  }

  final String title = "Initializing";

  //
  // @override
  // _DashboardState createState() => _DashboardState();

  void reload() {
    dashboardApi?.updateDashboard();
  }

  void updateGps(BuildContext context) {
    gpsService.retrieveLocation().then((position) {
      locationUpdater?.setLocation(position.latitude, position.longitude);
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
