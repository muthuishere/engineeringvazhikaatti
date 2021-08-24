import 'package:engineeringvazhikaatti/adapters/DistanceCalculator.dart';
import 'package:engineeringvazhikaatti/entities/results/AvailableCollege.dart';

class SortColleges {

  final DistanceCalculator _distanceCalculator ;

  SortColleges(this._distanceCalculator);


  List<AvailableCollege> sortByDistance(List<AvailableCollege> results, String branchCode,double lat2,double lon2) {

    results.forEach((element) {
      element.setSortableBranchWithCode(branchCode);
    });

    results.sort((a, b) {
      return _distanceCalculator.getDistanceBetween(a.location!.latitude!, a.location!.longitude!, lat2, lon2)
          .compareTo(_distanceCalculator.getDistanceBetween(b.location!.latitude!, b.location!.longitude!, lat2, lon2));
    });

    return results;

  }

  List<AvailableCollege> sortByRank(List<AvailableCollege> results, String branchCode) {

    results.forEach((element) {
      element.setSortableBranchWithCode(branchCode);
    });



    return sortBySortableBranch(results);


  }

  List<AvailableCollege> sortBySortableBranch(List<AvailableCollege> results) {

    results.sort((a, b) {
      return a
          .getRankForSortableBranch()
          .compareTo(b.getRankForSortableBranch());
    });
    return results;
  }
}
