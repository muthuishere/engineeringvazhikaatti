import 'package:engineeringvazhikaatti/entrypoints/dashboard_api.dart';
import 'package:engineeringvazhikaatti/stores/app_config_store.dart';
import 'package:engineeringvazhikaatti/stores/available_colleges_store.dart';
import 'package:engineeringvazhikaatti/stores/search_filter_store.dart';
import 'package:engineeringvazhikaatti/usecases/location_updater.dart';
import 'package:engineeringvazhikaatti/usecases/search_colleges_by_community_and_cutoff.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';
import 'package:engineeringvazhikaatti/usecases/sort_colleges.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_api_test.mocks.dart';


@GenerateMocks([SearchCollegesByCommunityAndCutoff,AvailableCollegesStore
,SearchFilterStore,SettingsUpdater,LocationUpdater,AppConfigStore,SortColleges
])
void main() {

 var _searchCollegesByCommunityAndCutoff = MockSearchCollegesByCommunityAndCutoff();
 var _availableCollegesStore = MockAvailableCollegesStore();
 var _searchFilterStore = MockSearchFilterStore();
 var _settingsUpdater = MockSettingsUpdater();
 var _locationUpdater = MockLocationUpdater();
 var _appConfigStore = MockAppConfigStore();
 var _sortColleges = MockSortColleges();
 DashboardApi dashboardApi= DashboardApi(_searchCollegesByCommunityAndCutoff,
   _availableCollegesStore,
   _searchFilterStore,
   _settingsUpdater,
   _locationUpdater,
   _appConfigStore,
   _sortColleges,
 );

  test('Dashboard Api should invoke showError if no data', () {

    when(_settingsUpdater.hasAllData()).thenReturn(false);
    when(_availableCollegesStore.showLoading()).thenReturn(false);
    dashboardApi.updateDashboard();
    verify(_availableCollegesStore.showError(any));
  });

  test('Dashboard Api should invoke updateDashboardByDistance followed by showerror if searchByDistrictsEnabled is false and no location', () {

    when(_settingsUpdater.hasAllData()).thenReturn(true);
    when(_availableCollegesStore.showLoading()).thenReturn(false);
    when(_searchFilterStore.searchByDistrictsEnabled).thenReturn(false);
    when(_locationUpdater.hasLocation()).thenReturn(false);

    dashboardApi.updateDashboard();
    verify(_availableCollegesStore.showError(any));
  });

  test('Dashboard Api should invoke updateDashboardByDistrict followed by showerror  if searchByDistrictsEnabled and no Districts been selected', () {

    when(_settingsUpdater.hasAllData()).thenReturn(true);
    when(_availableCollegesStore.showLoading()).thenReturn(false);
    when(_searchFilterStore.searchByDistrictsEnabled).thenReturn(true);
    when(_searchFilterStore.hasDistrictsSelected()).thenReturn(false);


    dashboardApi.updateDashboard();
    verify(_availableCollegesStore.showError(any));
  });
}