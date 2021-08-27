import 'package:engineeringvazhikaatti/entities/containers/data_container.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/presentation/shared/text_styles.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';

import 'filter_panel.dart';

class Dashboard extends StatelessWidget {
  late final AvailableCollegesStore? availableCollegesStore;
  late final DashboardApi? dashboardApi;
  late final LocationUpdater? locationUpdater;
  late final appNotification;

  Dashboard({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    availableCollegesStore = injector.get<AvailableCollegesStore>();
    dashboardApi = injector.get<DashboardApi>();
    locationUpdater = injector.get<LocationUpdater>();
  }

//Search Bar Clicking
  // Sort By
  // List<AvailableCOllege> to be on Cards

  final String title = "Home";

  //
  // @override
  // _DashboardState createState() => _DashboardState();

  void gotoCollege() {
    dashboardApi?.updateDashboard();
  }

  Widget cardFor(BuildContext context, AvailableCollege availableCollege) {
    return InkWell(
      child: Card(
        child: ListTile(
          title: Text("${availableCollege.name}"),
        ),
        elevation: 8,
        shadowColor: Colors.green,
        margin: EdgeInsets.all(10),
      ),
      onTap: gotoCollege,
    );
  }

  Widget centerText(String text,TextStyle? textStyle) {
    return Center(
      child: Text(
        '${text}',
        style: textStyle,
      ),
    );
  }
  Widget resultsFor(BuildContext context) {
    return StreamBuilder<ListContainer<AvailableCollege>>(
        stream: availableCollegesStore?.data().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.dataStatus == DataStatus.NODATA) {
              return centerText(snapshot.data!.message,TextStyles.noData(context));
            } else if (snapshot.data?.dataStatus == DataStatus.ERROR) {
              return centerText(snapshot.data!.message,TextStyles.error(context));
            } else if (snapshot.data?.dataStatus == DataStatus.SUCCESS) {
              return ListView.builder(
                padding: const EdgeInsets.all(5.5),
                itemCount: snapshot.data?.items.length,
                itemBuilder: (context, index) {
                  AvailableCollege? item = snapshot.data?.items[index];
                  return cardFor(context, item!);
                },
              );
            }
          }
          return centerText('Loading Data',TextStyles.loading(context));

        });
  }

  @override
  Widget build(BuildContext context) {
    appNotification = () => AppNotification(context);

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
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            FilterPanel(),
            Expanded(
              child: Container(
                child: resultsFor(context),

              ),
            ),
            // Container(
            //   child: Center(
            //     child: Text(
            //       'Third widget',
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            //   color: Colors.orange,
            //   height: 100,
            // ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: gotoCollege,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  void updateGps(BuildContext context) {
    _determinePosition().then((position) {
      locationUpdater?.setLocation(position.latitude, position.longitude);
    }).catchError((msg) {
      appNotification().showError(msg);
      print("error" + msg.toString());
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
