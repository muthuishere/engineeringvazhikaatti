
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TestInitializer{

  TestInitializer._();

  static void initLogs(){
    Loggy.initLoggy(
      logPrinter: const PrettyPrinter(
        showColors: true,
      ),
      // logOptions: const LogOptions(
      //   LogLevel.all,
      //   stackTraceLevel: LogLevel.off,
      // ),
    );
  }

}