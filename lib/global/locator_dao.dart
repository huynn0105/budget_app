import 'package:budget_app/core/database/daos/account_dao.dart';
import 'package:budget_app/core/database/daos/category_dao.dart';
import 'package:budget_app/core/database/daos/transaction_dao.dart';
import 'package:get_it/get_it.dart';

void registerDaoSingletons(GetIt locator) {
  locator.registerLazySingleton(() => TransactionDao());
  locator.registerLazySingleton(() => AccountDao());
  locator.registerLazySingleton(() => CategoryDao());
}
