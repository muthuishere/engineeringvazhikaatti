import 'package:engineeringvazhikaatti/entities/models/YearDetail.dart';

class AvailableBranch {
  String? code;
  String? name;
  List<YearDetail> yearDetails = List.empty();

  AvailableBranch(this.code, this.name, this.yearDetails);

  isValidBranch() {
    if (null == yearDetails || yearDetails.isEmpty) return false;

    return true;
  }
}
