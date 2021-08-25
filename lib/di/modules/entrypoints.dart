import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:injector/injector.dart';

class Entrypoints {


  init() {
    final injector = Injector.appInstance;

    var searchCollegesByCommunityAndCutoff =
        injector.get<SearchCollegesByCommunityAndCutoff>();
    var availableCollegesStore = injector.get<AvailableCollegesStore>();
    injector.registerSingleton<DashboardApi>(() => DashboardApi(
        searchCollegesByCommunityAndCutoff, availableCollegesStore));
  }
}
