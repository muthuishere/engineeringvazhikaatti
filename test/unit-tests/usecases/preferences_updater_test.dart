import 'package:engineeringvazhikaatti/usecases/PreferencesUpdater.dart';
import 'package:test/test.dart';

void main() {
  test('Preference Updater', () {

    var updater=PreferencesUpdater();
    updater.setBranchCodes(["CS","IT"]);
    updater.setDistricts(["Chennai","Chengalpattu","Thiruvallur"]);
    expect(updater.preferences.districts,["Chennai","Chengalpattu","Thiruvallur"]);
    expect(updater.preferences.branchCodes,["CS","IT"]);
  });
}