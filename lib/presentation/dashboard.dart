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

class Dashboard extends StatelessWidget {
  late final AvailableCollegesStore? availableCollegesStore;
  late final DashboardApi? dashboardApi;
  late final LocationUpdater? locationUpdater;
  late final AppNotification appNotification;
  late final  GpsService gpsService;

  Dashboard({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    availableCollegesStore = injector.get<AvailableCollegesStore>();
    dashboardApi = injector.get<DashboardApi>();
    locationUpdater = injector.get<LocationUpdater>();
    gpsService = GpsService();
  }

  final String title = "Engg Vazhikatti";

  //
  // @override
  // _DashboardState createState() => _DashboardState();

  void reload() {
    dashboardApi?.updateDashboard();
  }

  String formattedCutOffForYear(AvailableBranch branch, int year) {
    double? cutOffForYear = branch.cutOffForYear(year);
    if (null != cutOffForYear)
      return cutOffForYear.toString();
    else
      return "-";
  }

  Color calculatePositiveColorFor(int rank) {
    const colors = [
      Color(0xff0b6623),
      Color(0xff00755e),
      Color(0xff3f704d),
      Color(0xff708238),
      Color(0xffc49102),
      Color(0xfff9a602),
      Color(0xffF37000)
    ];

    if (rank < 10)
      return colors[0];
    else if (rank < 30)
      return colors[1];
    else if (rank < 50)
      return colors[2];
    else if (rank < 70)
      return colors[3];
    else if (rank < 90)
      return colors[4];
    else if (rank < 100)
      return colors[5];
    else
      return colors[6];
  }

  List<TableRow> buildBranch(BuildContext context, AvailableBranch branch) {
    return [
      TableRow(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            child: Text(branch.getRank().toString()),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(5),
                primary: calculatePositiveColorFor(branch.getRank())),
          ),
          Text(branch.name!, style: Theme.of(context).textTheme.bodyText2),
          Text(formattedCutOffForYear(branch, 2020),
              style: Theme.of(context).textTheme.bodyText2),
          Text(formattedCutOffForYear(branch, 2019),
              style: Theme.of(context).textTheme.bodyText2),
          Text(formattedCutOffForYear(branch, 2018),
              style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
      TableRow(children: [
        const SizedBox(height: 8.0),
        const SizedBox(height: 8.0),
        const SizedBox(height: 8.0),
        const SizedBox(height: 8.0),
        const SizedBox(height: 8.0),
      ])
    ];
  }

  Widget buildBranchesTable(
      BuildContext context, AvailableCollege availableCollege) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(50),
        4: FixedColumnWidth(50),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          // decoration: const BoxDecoration(
          //   color: Colors.grey,
          // ),

          children: <Widget>[
            Text("", style: Theme.of(context).textTheme.bodyText1),
            Text("", style: Theme.of(context).textTheme.bodyText1),
            Text("2020 ", style: Theme.of(context).textTheme.subtitle2),
            Text("2019", style: Theme.of(context).textTheme.subtitle2),
            Text("2018", style: Theme.of(context).textTheme.subtitle2),
          ],
        ),
        for (var branch in availableCollege.branches!)
          for (var wid in buildBranch(context, branch)) wid
      ],
    );
  }

  Widget buildCollege(BuildContext context, AvailableCollege availableCollege) {
    return Padding(
      key: Key(availableCollege.id!.toString()),
      padding: const EdgeInsets.all(10.0),
      child: Card(
          color: Colors.white,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(availableCollege.name!,
                                style: Theme.of(context).textTheme.headline5),
                            Text(availableCollege.address!,
                                style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(height: 16.0),
                            buildBranchesTable(context, availableCollege),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            onTap: () => gotoCollege(availableCollege),
          )),
    );
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

  Widget showLoading(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            Container(
              child: LinearProgressIndicator(),
            ),
            Text(
              '${'Loading Data'}',
              style: TextStyles.loading(context),
            )

          ]
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
                      child: Text(dashboardApi!.msg,style: Theme.of(context).textTheme.subtitle1),
                    )
                        ,
                        buildCollege(context, item!),
                      ],
                    );
                  else
                    return buildCollege(context, item!);
                },
              );
            }
          }
          return showLoading(context);
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
