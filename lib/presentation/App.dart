
import 'package:engineeringvazhikaatti/presentation/initialize.dart';
import 'package:engineeringvazhikaatti/presentation/settings_page.dart';
import 'package:engineeringvazhikaatti/presentation/shared/size_config.dart';
import 'package:flutter/material.dart';

import 'about_page.dart';
import 'dashboard.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Engineering Vazhikatti 2021',
        theme: ThemeData(
            fontFamily: 'OpenSans'
        ),
        initialRoute: "/home",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
           "/init": (BuildContext context) => new Initialize(),
           "/home": (BuildContext context) => new Dashboard(),
           "/settings": (BuildContext context) => new SettingsPage(),
           "/about": (BuildContext context) => new AboutPage(),
          // "/articles": (BuildContext context) => new Articles(),
          // "/elements": (BuildContext context) => new Elements(),
          // "/account": (BuildContext context) => new Register(),
          // "/pro": (BuildContext context) => new Pro(),
        });
    //
    // return MaterialApp(
    //   title: 'Engineering Vazhikatti 2021 Admissions',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Dashboard(title: 'Search Colleges Across'),
    // );
  }
}
