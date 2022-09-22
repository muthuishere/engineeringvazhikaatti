import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class BranchSelector {
  getAllBranches(AppConfigStore appConfigStore) {
    return appConfigStore
        .getBranches()
        .map((enggBranch) =>
            MultiSelectItem<String>(enggBranch.code, enggBranch.name))
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
