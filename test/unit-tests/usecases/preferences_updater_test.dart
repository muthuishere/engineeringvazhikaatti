import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/search_filter_updater.dart';
import 'package:test/test.dart';

void main() {
  test('Preference Updater', () async  {

    var updater=SearchFilterUpdater(SearchFilterStore());
    updater.setBranchCodes(["CS","IT"]);
    updater.setDistricts(["Chennai","Chengalpattu","Thiruvallur"]);
    expect(updater.searchFilter.districts,["Chennai","Chengalpattu","Thiruvallur"]);
    expect(updater.searchFilter.branchCodes,["CS","IT"]);
  });
}