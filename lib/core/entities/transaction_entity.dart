import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:objectbox/objectbox.dart';

import 'base_entity.dart';

@Entity()
class Transaction extends BaseEntity {
  @override
  int id = 0;
  String title;
  @Property(type: PropertyType.date)
  DateTime dateTime;
  int amount;
  TransactionType type;
  final account = ToOne<Account>();
  final category = ToOne<Category>();
  Transaction({
    required this.title,
    required this.dateTime,
    required this.amount,
    this.type = TransactionType.expense,
  });

  Transaction copyWith({
    int? id,
    String? title,
    DateTime? dateTime,
    int? amount,
    int? categoryId,
    int? accountId,
  }) {
    return Transaction(
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
    );
  }
}

enum TransactionType {
  expense,
  income,
}
