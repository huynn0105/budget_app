import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Account extends BaseEntity {
  @override
  int id;
  final String name;
  @Property(type: PropertyType.date)
  final DateTime createTime = DateTime.now();

  @Backlink()
  final transactions = ToMany<Transaction>();

  Account({
    this.id = 0,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name, createTime];
}
