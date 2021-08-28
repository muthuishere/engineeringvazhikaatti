import 'package:engineeringvazhikaatti/entities/models/caste.dart';
import 'package:engineeringvazhikaatti/entities/settings.dart';
import 'package:engineeringvazhikaatti/shared/string_extension.dart';
import 'package:engineeringvazhikaatti/usecases/settings_updater.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AboutPage extends StatelessWidget {
  late final SettingsUpdater settingsUpdater;
  late var appform = null;

  AboutPage({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;
    settingsUpdater = injector.get<SettingsUpdater>();
  }

  String longText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
  double size = 100, fontSize = 8;

  final String title = "About";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(25),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Center(
                      child: Image.asset('assets/images/main_image.png'),
                    ),
                    const SizedBox(height: 16.0),
                    Text("Why This Project",
                        style: Theme.of(context).textTheme.headline5),
                    const SizedBox(height: 16.0),
                    Text(
                        "My Cousin was trying to get into Engineering this year Tamilnadu Engineering Admissions 2021 , I am thinking of identifying and prioritizing colleges for her.",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 8.0),
                    Text("I could see the following problems",
                        style: Theme.of(context).textTheme.bodyText1),
                    ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title: Text(
                          'I know some Good Colleges, Will my Cutoff be sufficient to get in?'),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title: Text(
                          'It was hard to watch all the colleges and its seat positions, What would be the colleges should i target based on my cutoff?'),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title: Text(
                          'Also will that be available to my community based on cutoff?'),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title: Text('Will that be around within district ?'),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                        "After some research , I could able to gather data on cutoff for community for the last three years.",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 8.0),
                    Text(
                        "I could do some math with data and got what colleges i might get in.",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 8.0),
                    Text(
                        "I have hard time prioritizing colleges , My friend sasi advised me to rank branches in college than colleges.",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 8.0),
                    Text(
                        "This app will gather your marks , community , branch preferences and provide you an approximate list of colleges , which you should target for.",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 8.0),
                    Text("The results is based on ",
                        style: Theme.of(context).textTheme.bodyText1),
                    ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title:
                          Text('Cutoff for last three years for the community'),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_forward_rounded),
                      title: Text('Sorted by branch ranks'),
                    ),
                    const SizedBox(height: 30.0),
                    Text("Credits",
                        style: Theme.of(context).textTheme.headline5),
                    const SizedBox(height: 15.0),
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Agalya'),
                    ),
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Sasi'),
                    ),
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Mahe'),
                    ),
                  ]),
            )),
      ),
    );
  }
}
