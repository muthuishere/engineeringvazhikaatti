import '../datastatus.dart';

class Container<T>{
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

  Container();

  static Container fromData<T>(T contents) {
    var res = Container<T>();
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