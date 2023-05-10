import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/cutoff_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all_year_cutoff_widget.dart';

class BranchWithAllYearCutoffWidget extends StatelessWidget {
  final BranchWithCollege branchWithCollege;


  BranchWithAllYearCutoffWidget({Key? key, required this.branchWithCollege}) : super(key: key) {

    // Get college with branches widget

  }


  @override
  Widget build(BuildContext context) {

         return   Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             const SizedBox(height: 16.0),
             Text(branchWithCollege.name,
                 style: Theme.of(context).textTheme.subtitle1),
             const SizedBox(height: 16.0),
             AllYearCutoffWidget(branchWithCollege: branchWithCollege),

           ],
         );
  }


}
