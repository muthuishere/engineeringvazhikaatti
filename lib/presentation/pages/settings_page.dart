
import 'package:engineeringvazhikaatti/entities/models/request/community_group.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/shared/string_extension.dart';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../stores/settings_store.dart';

class SettingsPage extends StatelessWidget {
  late final SettingsStore settingsUpdater;
  late var appform = null;

  SettingsPage({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    settingsUpdater = injector.get<SettingsStore>();
  }




  markValidator() {
    return [
      Validators.required,
      Validators.min(35),
      Validators.max(100)
    ];
  }

  getFormGroup() {
    Settings settings = settingsUpdater.getSettings();
    return () => fb.group(<String, Object>{
          'maths': FormControl<double>(
            value: settings.maths,
            validators: markValidator(),
          ),
          'physics': FormControl<double>(
            value: settings.physics,
            validators: markValidator(),
          ),
          'chemistry': FormControl<double>(
            value: settings.chemistry,
            validators: markValidator(),
          ),
          'communityGroup': FormControl<CommunityGroup>(
            value: settings.communityGroup,
            validators: [Validators.required],
          ),
        });
  }

  final String title = "Settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          actions: <Widget>[
            IconButton(

                onPressed: () {
                  saveapp(context);
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                )
                )

          ],
        ),
        body: Padding(
          // Even Padding On All Sides
          padding: EdgeInsets.all(15.0),

          child: settingsFor(context),
        ));
  }

  getAllCommunityGroups() {
    List<DropdownMenuItem<CommunityGroup>> items = [];

    for (var currentValue in CommunityGroup.values) {
      items.add(DropdownMenuItem(
        value: currentValue,
        child: Text(currentValue.label()),
      ));
    }
    return items;
  }

  Widget getMarkWidget(String name) {
    return ReactiveTextField<double>(
      formControlName: name,
      validationMessages: (control) => {
        ValidationMessage.required:
            name.toTitleCase() + ' Marks should not be empty',
        ValidationMessage.min: 'The Minimum marks should be 35',
        ValidationMessage.max:
            'The Maximum mark should be less than or equal to 100',
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: name.toTitleCase() + ' Marks',
        helperText: '',
        helperStyle: TextStyle(height: 0.7),
        labelStyle: TextStyle(height: 0.7),
        errorStyle: TextStyle(height: 0.7),
      ),
    );
  }

  void saveapp(BuildContext context) {
    //print(appform!.value);
   // print(appform!.valid);
    FocusScope.of(context).requestFocus(FocusNode());

    if (appform!.valid) {
      settingsUpdater.update(
          appform!.value['physics'],
          appform!.value['chemistry'],
          appform!.value['maths'],
          appform!.value['communityGroup']);
      Navigator.pop(context);
    } else {
      appform!.markAllAsTouched();
    }
  }

  Widget formUiBuilder(context, form, child) {
    appform = form;

    return Column(
      children: [
        getMarkWidget('maths'),
        const SizedBox(height: 16.0),
        getMarkWidget('physics'),
        const SizedBox(height: 16.0),
        getMarkWidget('chemistry'),
        const SizedBox(height: 16.0),
        ReactiveDropdownField<CommunityGroup>(
          formControlName: 'communityGroup',
          hint: Text('Select CommunityGroup...'),
          items: getAllCommunityGroups(),
        )
      ],
    );
  }

  Widget settingsFor(BuildContext context) {
    return ReactiveFormBuilder(
        form: getFormGroup(),
        builder: (context, form, child) {
          return formUiBuilder(context, form, child);
        });
  }
}
