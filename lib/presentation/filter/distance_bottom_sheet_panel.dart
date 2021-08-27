import 'package:engineeringvazhikaatti/entities/containers/data_container.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/filter.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/presentation/shared/text_styles.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DistanceBottomSheetPanel {
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
        return MultiSelectBottomSheet(
            items: getAllDistances(appConfigStore),
            initialValue: getSelectedDistances(appConfigStore,distanceInKm),
            onConfirm: (values) {
              print(values);
              if(null != values && values.length > 0)
                callback(values[0]);
            });
      },
    );
  }
}
