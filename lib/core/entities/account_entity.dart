// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/translation/keyword.dart';

@Entity()
class Account extends BaseEntity {
  @override
  int id;
  final String name;
  final String emoji;
  final bool active;
  @Backlink()
  final transactions = ToMany<Transaction>();
  Account({
    this.id = 0,
    required this.name,
    required this.emoji,
    this.active = true,
  });

  static List<Account> accountsDefault = [
    Account(name: KeyWork.cash, emoji: '💵'),
    Account(name: KeyWork.card, emoji: '💳'),
  ];

  @override
  List<Object?> get props => [id, name, emoji, active];

  @override
  bool? get stringify => true;

  Account copyWith({
    int? id,
    String? name,
    String? emoji,
    bool? active,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      active: active ?? this.active,
    );
  }
}
