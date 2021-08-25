import 'modules/entrypoints.dart';
import 'modules/stores.dart';
import 'modules/usecases.dart';

import 'modules/adapters.dart';

init() async{
  var adapters = Adapters();
  var stores = Stores();
  var usecases = Usecases();
  var entrypoints = Entrypoints();
  stores.init();
  adapters.init();
  usecases.init();
  entrypoints.init();
}
