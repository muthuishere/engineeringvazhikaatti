import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/all_year_cutoff_widget.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/branch_with_all_year_cutoff_widget.dart';
import 'package:engineeringvazhikaatti/stores/available_branch_detail_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class CollegeWithBranchesWidget extends StatelessWidget {
  late final BranchWithCollege branchWithCollege;
late final AvailableBranchDetailStore availableBranchDetailStore;
late final List<BranchWithCollege> items;
  CollegeWithBranchesWidget({Key? key, required this.branchWithCollege}) : super(key: key) {

    final   injector = Injector.appInstance;
    availableBranchDetailStore = injector.get<AvailableBranchDetailStore>();
    items= availableBranchDetailStore.getAllBranchesIn(branchWithCollege,2021);
    // Get college with branches widget


  }


  @override
  Widget build(BuildContext context) {
    // return buildCollege(context, branchWithCollege);
    return   Column(children: [

      Container(
          child:
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                for (var i = 0; i < items.length; i++) BranchWithAllYearCutoffWidget(branchWithCollege: items[i]),







              ],
            ),
          ),

    )]
      );


  }


}
