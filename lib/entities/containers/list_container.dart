import '../datastatus.dart';

class ListContainer<T>{
  List<T> items = List.empty();
  DataStatus dataStatus = DataStatus.LOADING;
  String message = "";

  @override
  String toString() {
    return toJson().toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v?.toString()).toList();
    }

      data['dataStatus'] =dataStatus.toString();
      data['message'] =message.toString();

    return data;
  }

  setLoading() {
    dataStatus = DataStatus.LOADING;
    items = List.empty();
  }

  setData(List<T> items) {
    dataStatus = DataStatus.SUCCESS;
    this.items = items;
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

  static ListContainer<T> withError<T>(String msg) {
    var res = ListContainer<T>();

      res.setError(msg);

    return res;
  }

  void setNoData() {
    this.dataStatus = DataStatus.NODATA;
    this.message = "No Data for selected criteria";
  }

  static fromLoading<T>() {

    var res = ListContainer<T>();

    res.dataStatus = DataStatus.LOADING;

    return res;
  }
}