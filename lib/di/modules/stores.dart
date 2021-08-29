import 'package:engineeringvazhikaatti/adapters/file_reader.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/stores/college_details_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:injector/injector.dart';

class Stores {
  Future<AppConfigStore> getAppConfigStore() async{

    final injector = Injector.appInstance;
    var fileReader  = injector.get<FileReader>();

    var districts = await fileReader.readFromAssetsFolder("districts.json");
    var pincodes = await fileReader.readFromAssetsFolder("pincodes.json");
    var branches = await fileReader.readFromAssetsFolder("allbranches.json");

    print("branches size" + branches.length.toString());
    var appConfigStore = AppConfigStore();
    appConfigStore.loadDistricts(districts);
    appConfigStore.loadPincodes(pincodes);
    appConfigStore.loadBranches(branches);
    return  appConfigStore;

  }
  Future<CollegeDetailsStore> getCollegeDetailsStore() async {
    final injector = Injector.appInstance;

    var fileReader  = injector.get<FileReader>();
    var collegeDetails = await fileReader.readFromAssetsFolder("colleges.json");
   // print("collegeDetails size" + collegeDetails.length.toString());
    CollegeDetailsStore collegeDetailsStore  =CollegeDetailsStore.from(collegeDetails);
    //print("Total Colleges size" + collegeDetailsStore.collegeDetails.length.toString());
    return collegeDetailsStore;
  }

  init() async{
    final injector = Injector.appInstance;
    var collegeDetailsStore = await getCollegeDetailsStore();
    var appConfigStore = await getAppConfigStore();

    injector.registerSingleton<CollegeDetailsStore>(() => collegeDetailsStore);
    injector.registerSingleton<AppConfigStore>(() =>appConfigStore);

    injector.registerSingleton<AvailableCollegesStore>(() => AvailableCollegesStore());
    injector.registerSingleton<SearchFilterStore>(() => SearchFilterStore());


  }




}
