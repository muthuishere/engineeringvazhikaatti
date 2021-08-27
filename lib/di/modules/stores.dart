import 'package:engineeringvazhikaatti/providers/io/flutter_file_reader.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/stores/college_details_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:injector/injector.dart';

class Stores {
  AppConfigStore getAppConfigStore(){

    var districts = FlutterFileReader().readFromAssetsFolder("districts.json");
    var pincodes = FlutterFileReader().readFromAssetsFolder("pincodes.json");
    var branches = FlutterFileReader().readFromAssetsFolder("allbranches.json");

    var appConfigStore = AppConfigStore();
    appConfigStore.loadDistrictsFromFuture(districts);
    appConfigStore.loadPincodesFromFuture(pincodes);
    appConfigStore.loadBranchesFromFuture(branches);
    return  appConfigStore;

  }
  init() {
    final injector = Injector.appInstance;

    var collegeDetails = FlutterFileReader().readFromAssetsFolder("colleges.json");

    injector.registerSingleton<CollegeDetailsStore>(() => CollegeDetailsStore.fromFuture(collegeDetails));
    injector.registerSingleton<AppConfigStore>(() => getAppConfigStore());

    injector.registerSingleton<AvailableCollegesStore>(() => AvailableCollegesStore());
    injector.registerSingleton<SearchFilterStore>(() => SearchFilterStore());


  }


}
