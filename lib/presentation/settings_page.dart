import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/shared/string_extension.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SettingsPage extends StatelessWidget {



  late final SettingsUpdater settingsUpdater;
  late var appform =null;


  SettingsPage({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    settingsUpdater = injector.get<SettingsUpdater>();

  }

  markValidator(){
    return [
      Validators.required,
      Validators.number,
      Validators.min(35),
      Validators.max(100)
    ];
  }
  getFormGroup(){
    Settings settings =settingsUpdater.settings;
    return () =>
        fb.group(<String, Object>{
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
          'communitygroup': FormControl<CommunityGroup>(
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
            icon: const Icon(Icons.save),
            tooltip: 'Save Settings',
            onPressed: () {
              saveapp(context);
            },
          ),
        ],
      ),
      body: Padding(
        // Even Padding On All Sides
          padding: EdgeInsets.all(10.0),

          child:settingsFor(context)
      ,
    )

    );
  }

   getAllCommunityGroups(){

    List<DropdownMenuItem<CommunityGroup>> items=[];

    for (var currentValue in CommunityGroup.values) {
      items.add(  DropdownMenuItem(
        value: currentValue,
        child: Text(currentValue.toValidString()),
      ));
    }
    return items;
  }
  Widget getMarkWidget(String name){

    return ReactiveTextField<double>(
      formControlName: name,
      validationMessages: (control) =>
      {
        ValidationMessage.required: name.toTitleCase() + ' Marks should not be empty',
        ValidationMessage.min:'The Minimum marks should be 35',
        ValidationMessage.max:'The Maximum mark should be less than or equal to 100',

      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        labelText:name.toTitleCase() + ' Marks',
        helperText: '',
        helperStyle: TextStyle(height: 0.7),
        labelStyle: TextStyle(height: 0.7),
        errorStyle: TextStyle(height: 0.7),
      ),
    );
  }
  void saveapp(BuildContext context) {

    if (appform!.valid) {
      settingsUpdater.update(appform!.value['physics'],appform!.value['chemistry'],appform!.value['maths'],appform!.value['communityGroup']);
    } else {
      appform!.markAllAsTouched();
    }
  }
  Widget formUiBuilder(context, form, child) {
    appform=form;

    return Column(
      children: [
        getMarkWidget('maths'),
        const SizedBox(height: 16.0),
        getMarkWidget('physics'),
        const SizedBox(height: 16.0),
        getMarkWidget('chemistry'),
        const SizedBox(height: 16.0),
        ReactiveDropdownField<CommunityGroup>(
          formControlName: 'communitygroup',
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
        return formUiBuilder(context,form,child);
      });

  }
}

