// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:expense_manager/core/entities/payment_entity.dart';
import 'package:expense_manager/core/entities/category_entity.dart';

import 'budget_entity.dart';
import 'base_entity.dart';

@Entity()
class Transaction extends BaseEntity {
  @override
  int id;
  final String note;
  @Property(type: PropertyType.date)
  final DateTime dateTime;
  final int amount;
  @Transient()
  TransactionType type;

  final payment = ToOne<Payment>();
  final category = ToOne<Category>();
  final account = ToOne<Budget>();
  Transaction({
    this.id = 0,
    required this.note,
    required this.dateTime,
    required this.amount,
    this.type = TransactionType.expense,
  });

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
        note,
        type,
        amount,
        dateTime,
        payment.targetId,
        category.targetId,
      ];

  Transaction copyWith({
    int? id,
    String? note,
    DateTime? dateTime,
    int? amount,
    TransactionType? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      note: note ?? this.note,
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
