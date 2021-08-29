import '../shared/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';


class LoadingIndicator extends StatelessWidget {

  LoadingIndicator({Key? key}) : super(key: key) {
    final injector = Injector.appInstance;

  }

  Widget showLoading(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            Container(
              child: LinearProgressIndicator(),
            ),
            Text(
              '${'Loading Data'}',
              style: TextStyles.loading(context),
            )

          ]
        ));
  }


  @override
  Widget build(BuildContext context) {

    return showLoading(context);
  }

}
