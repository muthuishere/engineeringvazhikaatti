import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:engineeringvazhikaatti/presentation/shared/dropdown/multi_select_bottom_sheet_with_options.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';

import 'package:flutter/material.dart';

import '../../shared/dropdown/util/multi_select_item.dart';


class DistanceSelector {
  getAllDistances(AppConfigStore appConfigStore) {
    return appConfigStore
        .getDistances()
        .map((district) =>
            MultiSelectItem<int>(district.distance, district.label))
        .toList();
  }

  getSelectedDistances(AppConfigStore appConfigStore,int distanceInKm) {


    var results =appConfigStore
        .getDistances()
        .where((element) => element.distance == distanceInKm)
        .map((district) =>district.distance)
        .toList();

    return results;

  }

  void showMultiSelectDistances(
      appConfigStore, distanceInKm, BuildContext context, callback) async {





    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheetWithOptions(
            items: getAllDistances(appConfigStore),
            initialValue: getSelectedDistances(appConfigStore,distanceInKm),
            maxSelectedItems: 1,
            onConfirm: (values) {
             // print(values);
              if(null != values && values.length > 0)
                callback(values[0]);
            });
      },
    );
  }
}
