import 'package:budget_app/core/database/hive_constants.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:hive/hive.dart';

import 'base_entity.dart';
part 'transaction_entity.g.dart';

@HiveType(typeId: HiveTypes.transaction)
class Transaction extends BaseEntity {
  @HiveField(1)
  final String note;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  final int amount;
  @HiveField(4)
  TransactionType type;
  @HiveField(5)
  Category category;
  @HiveField(6)
  Payment payment;

  Transaction({
    required this.note,
    required this.dateTime,
    required this.amount,
    this.type = TransactionType.expense,
    required super.id,
    required this.category,
    required this.payment,
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
      ];

  Transaction copyWith({
    String? id,
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
      category: this.category,
      payment: this.payment,
    );
  }
}

@HiveType(typeId: HiveTypes.transactionType)
enum TransactionType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
}
