import 'package:expense_manager/core/database/object_box.dart';
import 'package:expense_manager/global/locator_service.dart';
import 'package:get_it/get_it.dart';

import 'locator_dao.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => ObjectBox());
  registerServiceSingletons(locator);
  registerDaoSingletons(locator);
  await locator<ObjectBox>().create();
}
