import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle noData(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: Colors.blueGrey);
  }
  static TextStyle loading(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: Colors.blue);
  }

  static TextStyle error(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: Colors.deepOrangeAccent);
  }
}
