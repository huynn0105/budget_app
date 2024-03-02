// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:expense_manager/core/entities/base_entity.dart';
import 'package:expense_manager/core/entities/transaction_entity.dart';
import 'package:expense_manager/translation/keyword.dart';

@Entity()
class Payment extends BaseEntity {
  @override
  int id;
  final String name;
  final String emoji;
  final bool active;
  @Backlink()
  final transactions = ToMany<Transaction>();
  Payment({
    this.id = 0,
    required this.name,
    required this.emoji,
    this.active = true,
  });

  static List<Payment> paymentsDefault = [
    Payment(name: KeyWork.cash, emoji: '💵'),
    Payment(name: "Credit Card", emoji: '📇'),
  ];

  @override
  List<Object?> get props => [id, name, emoji, active];

  @override
  bool? get stringify => true;

  Payment copyWith({
    int? id,
    String? name,
    String? emoji,
    bool? active,
  }) {
    return Payment(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      active: active ?? this.active,
    );
  }
}
