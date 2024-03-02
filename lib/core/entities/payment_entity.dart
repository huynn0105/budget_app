import 'package:budget_app/core/database/hive_constants.dart';
import 'package:budget_app/core/entities/base_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'payment_entity.g.dart';
@HiveType(typeId: HiveTypes.payment)
class Payment extends BaseEntity {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String emoji;
  @HiveField(3)
  final bool active;
  Payment({
    required this.name,
    required this.emoji,
    this.active = true,
    required super.id,
  });

  static List<Payment> paymentsDefault = [
    Payment(name: 'Money', emoji: '💵', id: Uuid().v4()),
    Payment(name: 'Credit', emoji: '💳', id: Uuid().v4()),
  ];

  Payment copyWith({
    String? id,
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
