import 'dart:ui';

import 'package:engineeringvazhikaatti/entities/results/available_branch.dart';

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
