
import 'package:engineeringvazhikaatti/presentation/initialize.dart';
import 'pages/settings_page.dart';

import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'home/dashboard.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Engineering Vazhikatti 2022',
        theme: ThemeData(
            fontFamily: 'OpenSans'
        ),
        initialRoute: "/init",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
           "/init": (BuildContext context) => new Initialize(),
           "/home": (BuildContext context) => new Dashboard(),
           "/settings": (BuildContext context) => new SettingsPage(),
           "/about": (BuildContext context) => new AboutPage(),
        });

  }
}
