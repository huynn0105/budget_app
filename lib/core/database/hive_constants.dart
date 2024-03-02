import 'package:budget_app/core/entities/budget_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:hive/hive.dart';

class HiveTypes {
  static const int transaction = 1;
  static const int setting = 2;
  static const int payment = 3;
  static const int category = 4;
  static const int budget = 5;
  static const int transactionType = 6;
}

class HiveBoxName {
  static const String transaction = 'transaction';
  static const String setting = 'setting';
  static const String payment = 'payment';
  static const String category = 'category';
  static const String budget = 'budget';
}

class HiveBoxMap {
  static Map<Type, MyHive> hiveBoxMap = {
    Payment: MyHive<Payment>(
        boxName: HiveBoxName.payment,
        registerAdapterFunction: () {
          Hive.registerAdapter(PaymentAdapter());
        }),
    Category: MyHive<Category>(
        boxName: HiveBoxName.category,
        registerAdapterFunction: () {
          Hive.registerAdapter(CategoryAdapter());
        }),
    Transaction: MyHive<Transaction>(
        boxName: HiveBoxName.transaction,
        registerAdapterFunction: () {
          Hive.registerAdapter(TransactionAdapter());
          Hive.registerAdapter(TransactionTypeAdapter());
          //  Hive.registerAdapter(CategoryAdapter());
          //  Hive.registerAdapter(PaymentAdapter());
        }),
    Budget: MyHive<Budget>(
        boxName: HiveBoxName.budget,
        registerAdapterFunction: () {
          Hive.registerAdapter(BudgetAdapter());
        }),
  };
}

class MyHive<EntityT> {
  String boxName;
  late Future<void> Function() openBoxFunction;
  void Function() registerAdapterFunction;

  MyHive({required this.boxName, required this.registerAdapterFunction}) {
    this.openBoxFunction = () async {
      await Hive.openBox<EntityT>(boxName);
    };
  }
}
