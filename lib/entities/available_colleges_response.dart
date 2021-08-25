import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';

class AvailableCollegesResponse {
  List<AvailableCollege> availableColleges = List.empty();
  DataStatus dataStatus = DataStatus.LOADING;
  String message = "";

  setLoading() {
    dataStatus = DataStatus.LOADING;
    availableColleges = List.empty();
  }

  setData(List<AvailableCollege> availableColleges) {
    dataStatus = DataStatus.SUCCESS;
    this.availableColleges = availableColleges;
  }

  setError(String message) {
    dataStatus = DataStatus.ERROR;
    this.message = message;
    availableColleges = List.empty();
  }

  AvailableCollegesResponse();

  static AvailableCollegesResponse fromData(List<AvailableCollege> contents) {
    var res = AvailableCollegesResponse();
    if (contents.length > 0)
      res.setData(contents);
    else
      res.setNoData();

    return res;
  }

  void setNoData() {
    this.dataStatus = DataStatus.NODATA;
    this.message = "No Data for selected criteria";
  }
}
