import 'modules/entrypoints.dart';
import 'modules/stores.dart';
import 'modules/usecases.dart';

import 'modules/adapters.dart';

init() async{
  var adapters = Adapters();
  var stores = Stores();
  var usecases = Usecases();
  var entrypoints = Entrypoints();

  adapters.init();
  await stores.init();
  usecases.init();
  entrypoints.init();
}
