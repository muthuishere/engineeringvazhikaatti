import 'package:flutter/material.dart';

class AppNotification{

  final BuildContext context;

  AppNotification(this.context);


  showError(String text){
    final snackBar = SnackBar(content: Text('Error' + text));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showSuccess(String text){
    final snackBar = SnackBar(content: Text( text));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}