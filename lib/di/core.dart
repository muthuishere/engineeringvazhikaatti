import 'modules/entrypoints.dart';
import 'modules/stores.dart';


import 'modules/adapters.dart';

init() async{
  var adapters = Adapters();
  var stores = Stores();

  var entrypoints = Entrypoints();

  await adapters.init();
  await stores.init();
  entrypoints.init();
}
