import 'package:engineeringvazhikaatti/entities/models/response/branch_with_college.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:engineeringvazhikaatti/presentation/home/widgets/cutoff_widget.dart';
import 'package:engineeringvazhikaatti/stores/AppDefaultConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllYearCutoffWidget extends StatelessWidget {
  final BranchWithCollege branchWithCollege;
  List<int> years=AppDefaultConfig.getAvailableYears();

  AllYearCutoffWidget({Key? key, required this.branchWithCollege}) : super(key: key) {

    // Get college with branches widget

  }


  @override
  Widget build(BuildContext context) {
    // return buildCollege(context, branchWithCollege);
    Map<int, TableColumnWidth> columnwidths ={};
    for (var i = 0; i < years.length; i++)columnwidths[i]=FixedColumnWidth(50);


         return Table(
      columnWidths: columnwidths,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            for (var i = 0; i < years.length; i++) CutoffWidget(
              year: years[i],
              branchWithCollege: branchWithCollege,
            )

          ],
        ),

      ],
    );
  }


}
