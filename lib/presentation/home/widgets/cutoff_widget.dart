import 'package:engineeringvazhikaatti/entities/cutoffstatus.dart';
import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:engineeringvazhikaatti/stores/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class CutoffWidget extends StatelessWidget {

  late double cutoff;

  int year;
  late final double calendarSize;

  late String assetImage;

  late final SettingsStore _settingsStore;
  late Color textColor;
  BranchWithCollege branchWithCollege;
  // branchWithCollege: availableCollege,

  CutoffWidget({Key? key, required this.year, required this.branchWithCollege}) : super(key: key) {
    final injector = Injector.appInstance;
    _settingsStore = injector.get<SettingsStore>();
    this.cutoff = branchWithCollege.cutoffs[year] ?? 0;
    CutoffStatus cutoffStatus= _settingsStore.getSettings().getCutOffStatusWith(this.cutoff);
    assetImage= "assets/images/" + cutoffStatus.toString().split(".").last.toLowerCase() + "bg.png";

    textColor= Colors.black;
    calendarSize=75;
  }

  @override
  Widget build(BuildContext context) {
    // return buildCollege(context, branchWithCollege);
    return    Container(
        width: calendarSize,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    width: calendarSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("assets/images/blackbg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0,10,0,5), //apply padding to all four sides
                      child: Text(year.toString(),style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                    ),
                  ),

                ],),
              Row(
                children: [
                  Container(
                    width: calendarSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(assetImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(0,5,0,15), //apply padding to all four sides
                      child: Text(formatCutOff(cutoff),style: TextStyle(color: textColor,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                    ),
                    //
                    //
                    // Text(185.25.toString(),textAlign: TextAlign.center),
                    // padding: EdgeInsets.fromLTRB(10, 15, 10, 10)

                  ),
                ],)
            ]
    ));
  }

  String formatCutOff(double cutOffForYear) {

    if ( cutOffForYear > 0)
      return cutOffForYear.toStringAsFixed(2);
    else
      return "-";
  }

}
