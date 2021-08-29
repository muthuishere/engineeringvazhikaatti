import 'package:flutter/material.dart';
import 'di/core.dart' as di;
import 'presentation/App.dart';
import 'presentation/home/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await di.init();
  runApp(App());
}
