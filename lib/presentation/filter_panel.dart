import 'package:badges/badges.dart';
import 'package:engineeringvazhikaatti/entities/filter.dart';
import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_filter_updater.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'filter/branches_bottom_sheet_panel.dart';
import 'filter/distance_bottom_sheet_panel.dart';
import 'filter/districts_bottom_sheet_panel.dart';

class FilterPanel extends StatelessWidget {
  late final SearchFilterStore? searchFilterStore;
  late final AppConfigStore? appConfigStore;
  late final SearchFilterUpdater? searchFilterUpdater;
  late final DashboardApi? dashboardApi;
  late final LocationUpdater? locationUpdater;
  late final appNotification;
  bool canShowDistrict = false;
  late var appform = null;
  var branchesDetail = BranchesBottomSheetPanel();
  var distancesDetail = DistanceBottomSheetPanel();
  var districtsDetail = DistrictsBottomSheetPanel();

  FilterPanel({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    searchFilterStore = injector.get<SearchFilterStore>();
    searchFilterUpdater = injector.get<SearchFilterUpdater>();
    dashboardApi = injector.get<DashboardApi>();
    locationUpdater = injector.get<LocationUpdater>();
    appConfigStore = injector.get<AppConfigStore>();
  }

  getFormGroupForSearchByDistricts() {
    Filter searchFilter = searchFilterUpdater!.searchFilter;
    return () => fb.group(<String, Object>{
          'searchByDistricts': FormControl<bool>(
            value: searchFilterStore!.searchByDistrictsEnabled,
            validators: [],
          ),
          'distanceInKms': FormControl<int>(
            value: searchFilter.distanceInKms,
            validators: [],
          ),
          'selectedDistricts': FormControl<List<String>>(
            value: searchFilter.districts,
            validators: [],
          ),
          'selectedBranches': FormControl<List<String>>(
            value: searchFilter.branchCodes,
            validators: [],
          ),
        });
  }

  updateInStore(FormGroup form){
   // print(form.value);
    searchFilterUpdater!.setDistricts(form.control('selectedDistricts').value);
    searchFilterUpdater!.setBranchCodes(form.control('selectedBranches').value);
    searchFilterUpdater!.setDistanceInKms(form.control('distanceInKms').value);
    searchFilterUpdater!.setSearchByDistricts(form.control('searchByDistricts').value);
    dashboardApi!.updateDashboard();
  }
  void onBranchesDropDownSelected(List<String> values, form) {
    form.control('selectedBranches').value = values;
    updateInStore(form);
  }

  Widget branchesDropDown(context, form, child) {

    return   ElevatedButton(
        onPressed: () {
       //   print(form.control('selectedBranches').value);

          branchesDetail.showMultiSelectBranches(
              appConfigStore,
              form.control('selectedBranches').value,
              context,
                  (evt) => onBranchesDropDownSelected(evt, form));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Branches',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      );



  }

  void onDistanceDropDownSelected(int value, form) {
    form.control('distanceInKms').value = value;
    updateInStore(form);
  }

  Widget distanceDropDown(context, form, child) {
    return ElevatedButton(
      onPressed: () {
        distancesDetail.showMultiSelectDistances(
            appConfigStore,
            form.control('distanceInKms').value,
            context,
            (evt) => onDistanceDropDownSelected(evt, form));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Distance',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void onDistrictsDropDownSelected(List<String> values, form) {


    form.control('selectedDistricts').value = values;
    updateInStore(form);
  }

  Widget districtsDropDown(context, form, child) {
    return ElevatedButton(
      key: Key('distbutton'),
      onPressed: () {
        districtsDetail.showMultiSelectDistricts(
            appConfigStore, form.control('selectedDistricts').value, context,
            (evt) {
          onDistrictsDropDownSelected(evt, form);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Districts',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void toggle(form) {
    form.control('searchByDistricts').value =
        !(form.control('searchByDistricts').value);
  }

  Widget switchDistrictButton(context, form, child) {
    bool showDistricts = form.control('searchByDistricts').value;
    if (showDistricts) {
      return ElevatedButton(
        // style: ElevatedButton.styleFrom(
        //    primary: ThemeColors.primary,
        // ),
        onPressed: () {
          toggle(form);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'By District',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.developer_board,
              color: Colors.white,
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        // style: ElevatedButton.styleFrom(
        //   primary: ThemeColors.white,
        // ),
        onPressed: () {
          toggle(form);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'By Distance',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.edit_road,
              color: Colors.white,
            ),
          ],
        ),
      );
    }
  }

  Widget formDistrictBuilder(context, form, child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        switchDistrictButton(context, form, child),
        districtsDropDown(context, form, child),
        branchesDropDown(context, form, child),
      ],
    );
  }

  Widget formDistanceBuilder(context, form, child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        switchDistrictButton(context, form, child),
        distanceDropDown(context, form, child),
        branchesDropDown(context, form, child),
      ],
    );
  }

  Widget formUiBuilder(context, form, child) {
    appform = form;

    return ReactiveValueListenableBuilder<bool>(
      formControlName: 'searchByDistricts',
      builder: (context, control, child) {
        if (control.value! == true)
          return formDistrictBuilder(context, form, child);
        else
          return formDistanceBuilder(context, form, child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    appNotification = () => AppNotification(context);

    return Container(
      child: Center(
        child: ReactiveFormBuilder(
            form: getFormGroupForSearchByDistricts(),
            builder: (context, form, child) {
              return formUiBuilder(context, form, child);
            }),
      ),
      height: 100,
    );
  }
}
