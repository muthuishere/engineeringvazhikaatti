import 'package:engineeringvazhikaatti/entities/cutoffstatus.dart';
import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/all_year_cutoff_widget.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/college_with_branches_widget.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/cutoff_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'branch_with_all_year_cutoff_widget.dart';

class BranchWithCollegeWidget extends StatelessWidget {
  late final BranchWithCollege branchWithCollege;
  late final int sno;

  BranchWithCollegeWidget({Key? key, required BranchWithCollege item, required int sno}) : super(key: key) {
    this.branchWithCollege = item;
    this.sno = sno;
  }



  String getCollegeNamewithSno(){
    return sno.toString() + ". " + branchWithCollege.collegeDetail.name;
  }

  @override
  Widget build(BuildContext context) {
    // return buildCollege(context, branchWithCollege);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 10.0, bottom: 20.0),
            child: Container(
              // height: 280.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 3.0,
                        spreadRadius: 1.0)
                  ]),
              child:
              Column(children: [
                Container(
                  child:
              Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 15),
              child:  Container(
                child:

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Text(getCollegeNamewithSno(),
                        style: Theme.of(context).textTheme.headline6),
                    Text(branchWithCollege.collegeDetail.address,
                        style: Theme.of(context).textTheme.subtitle1),
                    const SizedBox(height: 16.0),
                    BranchWithAllYearCutoffWidget(branchWithCollege: branchWithCollege),
                    // Text(branchWithCollege.name,
                    //     style: Theme.of(context).textTheme.subtitle1),
                    // const SizedBox(height: 16.0),
                    //
                    // AllYearCutoffWidget(branchWithCollege: branchWithCollege),
                  ],
                ),
              ),
            )


                ),
                ExpansionTile(
                  backgroundColor: Colors.white24,

                  title: Text(
                    "",
                    style: TextStyle(fontFamily: "Sofia"),
                  ),

                  children: [
                    Padding(

                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 15),
                      child: CollegeWithBranchesWidget(branchWithCollege: branchWithCollege),
                    )
                  ],
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  gotoCollege(BranchWithCollege availableCollege) {}
}
