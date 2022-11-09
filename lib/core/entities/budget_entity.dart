import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Budget extends BaseEntity {
  @override
  int id;
  final String name;
  final String image;
  @Property(type: PropertyType.date)
  final DateTime createTime = DateTime.now();

  @Backlink()
  final transactions = ToMany<Transaction>();

  Budget({
    this.id = 0,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, createTime, image];
}
