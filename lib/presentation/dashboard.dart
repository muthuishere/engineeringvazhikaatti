

import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class Dashboard extends StatelessWidget {


  AvailableCollegesStore? availableCollegesStore;
   DashboardApi? dashboardApi;


  Dashboard({Key? key, required this.title}) : super(key: key){

    final injector = Injector.appInstance;
    availableCollegesStore = injector.get<AvailableCollegesStore>();
    dashboardApi = injector.get<DashboardApi>();
  }
//Search Bar Clicking
  // Sort By
  // List<AvailableCOllege> to be on Cards


  final String title;
  //
  // @override
  // _DashboardState createState() => _DashboardState();

  void _incrementCounter() {
    print("increment");
    dashboardApi?.updateDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Dashboard object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

            StreamBuilder<ListContainer<AvailableCollege>>(
                stream: availableCollegesStore?.data().stream,
                builder: (context, snapshot) {


                  if(snapshot.hasData ){
                    if(snapshot.data?.dataStatus == DataStatus.NODATA){
                      return Text(
                        '${snapshot.data!.message}',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }else if(snapshot.data?.dataStatus == DataStatus.SUCCESS){
                      return Text(
                        'item received ${snapshot.data!.items.length}',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }

                  }
                  return Text(
                    'Loading Data',
                    style: Theme.of(context).textTheme.headline4,
                  );

                }),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
