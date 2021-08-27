import '../datastatus.dart';

class DataContainer<T>{
  T? item = null;
  DataStatus dataStatus = DataStatus.LOADING;
  String message = "";

  setLoading() {
    dataStatus = DataStatus.LOADING;
    item = null;
  }

  setData(T item) {
    dataStatus = DataStatus.SUCCESS;
    this.item = item;
  }

  setError(String message) {
    dataStatus = DataStatus.ERROR;
    this.message = message;
    item = null;
  }

  DataContainer();

  static DataContainer fromData<T>(T contents) {
    var res = DataContainer<T>();
    if (null != contents)
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