import 'package:budget_app/core/database/object_box.dart';
import 'package:budget_app/global/locator_service.dart';
import 'package:get_it/get_it.dart';

import 'locator_dao.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => ObjectBox());
  registerServiceSingletons(locator);
  registerDaoSingletons(locator);
  await locator<ObjectBox>().create();
}
