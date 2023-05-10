import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loggy/loggy.dart';
import 'di/core.dart' as di;
import 'presentation/App.dart';
import 'presentation/home/dashboard.dart';

void main() async {
  if (kDebugMode)
    Loggy.initLoggy(
      logPrinter: const PrettyPrinter(
        showColors: true,
      ),
      logOptions: const LogOptions(
        LogLevel.all,
        stackTraceLevel: LogLevel.off,
      ),
      // filters: [
      //   BlacklistFilter([BlacklistedLoggy]),
      // ],
    );

  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
 await di.init();

  return runZonedGuarded(() async {
    runApp(App());
  }, (error, stack) {
    if (kDebugMode) {
      print(stack);
    }
    if (kDebugMode) {
      print(error);
    }
  });

}
Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
