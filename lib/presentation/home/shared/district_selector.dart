import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class DistrictSelector {
  getAllDistricts(AppConfigStore appConfigStore) {
    return appConfigStore
        .getDistricts()
        .map((district) =>
            MultiSelectItem<String>(district, district))
        .toList();
  }

  getSelectedDistricts(selectedDistricts) {
    return selectedDistricts
        .map((district) =>district)
        .toList();
  }

  void showMultiSelectDistricts(
      appConfigStore, selectedDistricts, BuildContext context, Function callback) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
            items: getAllDistricts(appConfigStore),

            initialValue: getSelectedDistricts(selectedDistricts),
            onConfirm: (values) {
              callback(values.map((e) => e.toString()).toList());
            });
      },
    );
  }
}
