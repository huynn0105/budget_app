import 'package:budget_app/core/database/hive_constants.dart';
import 'package:budget_app/core/entities/base_entity.dart';
import 'package:hive/hive.dart';
part 'budget_entity.g.dart';

@HiveType(typeId: HiveTypes.budget)
class Budget extends BaseEntity {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final DateTime createTime;

  Budget({
    required this.name,
    required this.image,
    required this.createTime,
    required super.id,
  });

  @override
  List<Object?> get props => [id, name, createTime, image];

  Budget copyWith({
    String? id,
    String? name,
    String? image,
    DateTime? dataTime,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createTime: dataTime ?? this.createTime,
    );
  }
}
