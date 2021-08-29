import 'package:engineeringvazhikaatti/entities/containers/data_container.dart';
import 'package:engineeringvazhikaatti/entities/containers/list_container.dart';
import 'package:engineeringvazhikaatti/entities/datastatus.dart';
import 'package:engineeringvazhikaatti/entities/filter.dart';
import 'package:engineeringvazhikaatti/entities/results/available_college.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'text_styles.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BranchSelector {
  getAllBranches(AppConfigStore appConfigStore) {
    return appConfigStore
        .getBranches()
        .map((enggBranch) =>
            MultiSelectItem<String>(enggBranch.code!, enggBranch.name!))
        .toList();
  }

  getSelectedBranches(List<String> selectedBranches) {
    return selectedBranches
        .map((district) =>district)
        .toList();
  }

  void showMultiSelectBranches(
      appConfigStore, selectedBranches, BuildContext context, callback) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size

      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
            searchable: true,
            items: getAllBranches(appConfigStore),
            initialValue: getSelectedBranches(selectedBranches),
            onConfirm: (rawInputs) {
           //   print(rawInputs);
              List<String> values = rawInputs.map((e) => e.toString()).toList();
              callback(values);
            });
      },
    );
  }
}
