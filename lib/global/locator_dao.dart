import 'package:expense_manager/core/database/daos/budget_dao.dart';
import 'package:expense_manager/core/database/daos/payment_dao.dart';
import 'package:expense_manager/core/database/daos/category_dao.dart';
import 'package:expense_manager/core/database/daos/setting_dao.dart';
import 'package:expense_manager/core/database/daos/transaction_dao.dart';
import 'package:get_it/get_it.dart';

void registerDaoSingletons(GetIt locator) {
  locator.registerLazySingleton(() => TransactionDao());
  locator.registerLazySingleton(() => PaymentDao());
  locator.registerLazySingleton(() => CategoryDao());
  locator.registerLazySingleton(() => SettingDao());
  locator.registerLazySingleton(() => BudgetDao());
}
