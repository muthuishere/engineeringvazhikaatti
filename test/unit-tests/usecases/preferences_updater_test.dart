import 'package:engineeringvazhikaatti/usecases/search_filter_updater.dart';
import 'package:test/test.dart';

void main() {
  test('Preference Updater', () {

    var updater=SearchFilterUpdater();
    updater.setBranchCodes(["CS","IT"]);
    updater.setDistricts(["Chennai","Chengalpattu","Thiruvallur"]);
    expect(updater.searchFilter.districts,["Chennai","Chengalpattu","Thiruvallur"]);
    expect(updater.searchFilter.branchCodes,["CS","IT"]);
  });
}