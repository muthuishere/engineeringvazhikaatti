import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:engineeringvazhikaatti/entities/distance_option.dart';
import 'package:engineeringvazhikaatti/entities/models/request/college_location.dart';
import 'package:engineeringvazhikaatti/entities/search_filter.dart';
import 'package:engineeringvazhikaatti/presentation/shared/appnotification.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/location_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../shared/branch_selector.dart';
import '../shared/distance_selector.dart';
import '../shared/district_selector.dart';

class FilterPanel extends StatelessWidget {
  late final SearchFilterStore searchFilterStore;
  late final AppConfigStore appConfigStore;

  late final LocationStore locationStore;
  late final appNotification;
  bool canShowDistrict = false;
  late var appform;
  var branchesDetail = BranchSelector();
  var distancesDetail = DistanceSelector();
  var districtsDetail = DistrictSelector();

  FilterPanel({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    searchFilterStore = injector.get<SearchFilterStore>();
    locationStore = injector.get<LocationStore>();
    appConfigStore = injector.get<AppConfigStore>();
  }

  getFormGroupForSearchByDistricts() {
    SearchFilter searchFilter = searchFilterStore.getSearchFilter();
    return () => fb.group(<String, Object>{
          'searchByDistricts': FormControl<bool>(
            value: searchFilter.searchByDistricts,
            validators: [],
          ),
          'distanceInKms': FormControl<int>(
            value: searchFilter.distanceInKms,
            validators: [],
          ),
          'year': FormControl<int>(
            value: searchFilter.year,
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

  updateInStore(FormGroup form) {
    // print(form.value);

    SearchFilter searchFilter = searchFilterStore.getSearchFilter();
    searchFilter.searchByDistricts = form.control('searchByDistricts').value;
    searchFilter.distanceInKms = form.control('distanceInKms').value;
    searchFilter.year = form.control('year').value;
    searchFilter.districts = form.control('selectedDistricts').value;
    searchFilter.branchCodes = form.control('selectedBranches').value;
    searchFilterStore.updateWith(searchFilter);
  }

  void onBranchesDropDownSelected(List<String> values, form) {
    form.control('selectedBranches').value = values;
    updateInStore(form);
  }


  Widget branchesDropDown(context, form, child) {
    return ElevatedButton(
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

  Widget switchDistrictContainerButton(context, form, child) {
    return StreamBuilder<CollegeLocation>(
        stream: locationStore.locationStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return switchDistrictButton(context, form, child);
          }
          return SizedBox.shrink();
        });
  }

  Widget switchDistrictButton(context, form, child) {
    bool showDistricts = form.control('searchByDistricts').value;
    if (showDistricts) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black, // background
        ),
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
              Icons.album_rounded,
              color: Colors.white,
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple, // background
        ),
        onPressed: () {
          toggle(form);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.album_rounded,
              color: Colors.white,
            ),
            Text(
              'By Distance',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
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
        switchDistrictContainerButton(context, form, child),
        districtsDropDown(context, form, child),
        branchesDropDown(context, form, child),
      ],
    );
  }

  Widget formDistanceBuilder(context, form, child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        switchDistrictContainerButton(context, form, child),
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
