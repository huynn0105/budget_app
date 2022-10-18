import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Account extends BaseEntity {
  @override
  int id = 0;
  final String name;
  final String emoji;
  @Backlink()
  final transactions = ToMany<Transaction>();
  Account({
    required this.name,
    required this.emoji,
  });

  static List<Account> accountsDefault = [
    Account(name: KeyWork.cash, emoji: '💵'),
    Account(name: KeyWork.card, emoji: '💳'),
  ];

  @override
  List<Object?> get props => [id, name, emoji];

  @override
  bool? get stringify => true;
}
