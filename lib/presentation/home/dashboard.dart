import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/results/available_branch.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/college.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/loading_indicator.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import '../gps/gps_service.dart';
import 'widgets/filter_panel.dart';
import 'shared/text_styles.dart';

class Dashboard extends StatelessWidget {
  late final AvailableCollegesStore? availableCollegesStore;
  late final DashboardApi? dashboardApi;
  late final LocationUpdater? locationUpdater;
  late final AppNotification appNotification;
  late final GpsService gpsService;

  Dashboard({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    availableCollegesStore = injector.get<AvailableCollegesStore>();
    dashboardApi = injector.get<DashboardApi>();
    locationUpdater = injector.get<LocationUpdater>();
    gpsService = GpsService();
  }

  final String title = "Engg Vazhikatti";

  void reload() {
    dashboardApi?.updateDashboard();
  }

  Widget centerText(String text, TextStyle? textStyle) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            '${text}',
            style: textStyle,
          ),
        ));
  }

  Widget resultsFor(BuildContext context) {
    return StreamBuilder<ListContainer<AvailableCollege>>(
        stream: availableCollegesStore?.data().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.dataStatus == DataStatus.NODATA) {
              return centerText(
                  snapshot.data!.message, TextStyles.noData(context));
            } else if (snapshot.data?.dataStatus == DataStatus.ERROR) {
              return centerText(
                  snapshot.data!.message, TextStyles.error(context));
            } else if (snapshot.data?.dataStatus == DataStatus.SUCCESS) {
              return ListView.builder(
                padding: const EdgeInsets.all(5.5),
                itemCount: snapshot.data?.items.length,
                itemBuilder: (context, index) {
                  AvailableCollege? item = snapshot.data?.items[index];

                  if (index == 0)
                    return Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                text: dashboardApi!.msg,
                                style: Theme.of(context).textTheme.subtitle1,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text:
                                          ".\nChange your cutoff details by clicking the settings icon in top right",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 8)),
                                ],
                              ),
                            )),
                        const SizedBox(height: 5.0),
                        College(item: item!),
                      ],
                    );
                  else
                    return College(item: item!);
                },
              );
            }
          }
          return LoadingIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
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
            FilterPanel(),
            Expanded(
              child: Container(
                child: resultsFor(context),
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: reload,
          tooltip: 'Refresh Data',
          child: Icon(Icons.refresh),
        ));
  }

  gotoCollege(AvailableCollege availableCollege) {}

  void updateGps(BuildContext context) {
    gpsService.retrieveLocation().then((position) {
      locationUpdater?.setLocation(position.latitude, position.longitude);
      reload();
    }).catchError((msg) {
      appNotification.showError(msg);
      print("error" + msg.toString());
    });
  }
}
