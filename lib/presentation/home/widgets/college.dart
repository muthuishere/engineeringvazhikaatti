import 'package:engineeringvazhikaatti/entities/results/available_branch.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/presentation/home/shared/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class College extends StatelessWidget {
  late final AvailableCollege college;

  College({Key? key, required AvailableCollege item}) : super(key: key) {
    this.college = item;
  }

  List<TableRow> buildBranch(BuildContext context, AvailableBranch branch) {
    return [
      TableRow(
        children: <Widget>[
          Tooltip(
            message: 'Rank Based on the highest cutoff last year',
            child: ElevatedButton(
              onPressed: () {},
              child: Text(branch.getRank().toString()),
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(5),
                  primary: calculatePositiveColorFor(branch.getRank())),
            ),
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

  @override
  Widget build(BuildContext context) {
    return buildCollege(context, college);
  }

  gotoCollege(AvailableCollege availableCollege) {}
}
