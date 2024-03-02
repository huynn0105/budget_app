import 'package:budget_app/core/services/implements/budget_service.dart';
import 'package:budget_app/core/services/implements/payment_service.dart';
import 'package:budget_app/core/services/implements/category_service.dart';
import 'package:budget_app/core/services/interfaces/ibudget_service.dart';
import 'package:budget_app/core/services/interfaces/ipayment_service.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:get_it/get_it.dart';

import '../core/services/implements/transaction_service.dart';

void registerServiceSingletons(GetIt locator) {
  locator
      .registerLazySingleton<ITransactionService>(() => TransactionService());
  locator.registerLazySingleton<ICategoryService>(() => CategoryService());
  locator.registerLazySingleton<IPaymentService>(() => PaymentService());
  locator.registerLazySingleton<IBudgetService>(() => AccountService());
}
