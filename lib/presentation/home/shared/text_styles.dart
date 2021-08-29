import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle noData(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2!;
  }
  static TextStyle loading(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2!;
  }

  static TextStyle error(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: Colors.deepOrangeAccent);
  }
}
