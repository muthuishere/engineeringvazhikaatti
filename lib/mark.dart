

// Define a custom Form widget.
import 'package:flutter/material.dart';

class MarkWidget extends StatefulWidget {
  const MarkWidget({Key? key}) : super(key: key);

  @override
  MarkState createState() {
    return MarkState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MarkState extends State<MarkWidget> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}