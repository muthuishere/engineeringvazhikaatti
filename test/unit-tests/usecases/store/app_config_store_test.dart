import 'dart:io';

import 'package:test/test.dart';

import '../shared/TestDataGenerator.dart';

void main() {

  test('App Config store should load all districts well', () {
   var appConfigStore = TestDataGenerator.getAppConfigStore();

    expect(appConfigStore.getBranches().length,94);
    expect(appConfigStore.getBranches()[0].name,"Civil Engineering");
    expect(appConfigStore.getDistricts().length,50);

  });
}