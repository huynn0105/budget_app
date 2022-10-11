// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';

import 'base_entity.dart';

@Entity()
class Transaction extends BaseEntity {
  @override
  int id = 0;
  final String title;
  @Property(type: PropertyType.date)
  final DateTime dateTime;
  final int amount;
  @Transient()
  TransactionType type;
  int _transactionType = 0;
  final account = ToOne<Account>();
  final category = ToOne<Category>();
  Transaction({
    required this.title,
    required this.dateTime,
    required this.amount,
    this.type = TransactionType.expense,
  }) {
    _transactionType = type.index;
  }

  set dbType(int value) {
    _ensureStableEnumValues();
    type = TransactionType.values[value];
    type = value >= 0 && value < TransactionType.values.length
        ? TransactionType.values[value]
        : TransactionType.expense;
  }

  int get dbType {
    _ensureStableEnumValues();
    return type.index;
  }

  void _ensureStableEnumValues() {
    assert(TransactionType.expense.index == 0);
    assert(TransactionType.income.index == 1);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        amount,
        account.targetId,
        category.targetId,
      ];

  Transaction copyWith({
    int? id,
    String? title,
    DateTime? dateTime,
    int? amount,
    TransactionType? type,
  }) {
    return Transaction(
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
      type: type ?? this.type,
    );
  }
}

enum TransactionType {
  expense,
  income,
}
