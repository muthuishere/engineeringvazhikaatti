import '../datastatus.dart';

class ListContainer<T>{
  List<T> items = List.empty();
  DataStatus dataStatus = DataStatus.LOADING;
  String message = "";

  setLoading() {
    dataStatus = DataStatus.LOADING;
    items = List.empty();
  }

  setData(List<T> availableColleges) {
    dataStatus = DataStatus.SUCCESS;
    this.items = availableColleges;
  }

  setError(String message) {
    dataStatus = DataStatus.ERROR;
    this.message = message;
    items = List.empty();
  }

  ListContainer();

  static ListContainer<T> fromData<T>(List<T> contents) {
    var res = ListContainer<T>();
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