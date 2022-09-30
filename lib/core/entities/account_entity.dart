import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Account implements BaseEntity {
  @override
  int id = 0;
  String name;
  String emoji;
  @Backlink()
  final transactions = ToMany<Transaction>();
  Account({
    required this.name,
    required this.emoji,
  });

  static List<Account> accountsDefault = [
    Account(name: 'Cash', emoji: '💵'),
    Account(name: 'Card', emoji: '💳'),
  ];
}
