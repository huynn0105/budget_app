
import 'package:budget_app/core/database/hive_constants.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'base_entity.dart';

part 'category_entity.g.dart';

@HiveType(typeId: HiveTypes.category)
class Category extends BaseEntity {
  @HiveField(1)
  final String emoji;
    @HiveField(2)
  final String name;
    @HiveField(3)
  final bool active;
  Category({
    required this.name,
    required this.emoji,
    this.active = true, required super.id,
  });

  static List<Category> cetegoriesDefault = [
    Category(name: KeyWork.food, emoji: '🥙', id: Uuid().v4()),
    Category(name: KeyWork.breakfash, emoji: '🍔', id: Uuid().v4()),
    Category(name: KeyWork.eating, emoji: '🍜', id: Uuid().v4()),
    Category(name: KeyWork.bike, emoji: '🚗', id: Uuid().v4()),
    Category(name: KeyWork.gas, emoji: '⛽', id: Uuid().v4()),
    Category(name: KeyWork.clothing, emoji: '👕', id: Uuid().v4()),
    Category(name: KeyWork.gifts, emoji: '🎁', id: Uuid().v4()),
    Category(name: KeyWork.entertainment, emoji: '🎞', id: Uuid().v4()),
    Category(name: KeyWork.tech, emoji: '📱', id: Uuid().v4()),
  ];

  @override
  List<Object?> get props => [name, id, emoji];

  Category copyWith({
    String? id,
    String? emoji,
    String? name,
    bool? active,
  }) {
    return Category(
      id: id ?? this.id,
      emoji: emoji ?? this.emoji,
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }
}
