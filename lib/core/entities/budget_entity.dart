import 'package:objectbox/objectbox.dart';

import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';

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

  Budget copyWith({
    int? id,
    String? name,
    String? image,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }
}
