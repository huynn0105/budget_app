// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/translation/keyword.dart';

import 'base_entity.dart';

@Entity()
class Category extends BaseEntity {
  @override
  int id;
  final String emoji;
  final String name;
  final bool active;

  @Backlink()
  final transactions = ToMany<Transaction>();
  Category({
    this.id = 0,
    required this.name,
    required this.emoji,
    this.active = true,
  });

  static List<Category> cetegoriesDefault = [
    Category(name: KeyWork.food, emoji: '🥙'),
    Category(name: KeyWork.breakfash, emoji: '🍔'),
    Category(name: KeyWork.eating, emoji: '🍜'),
    Category(name: KeyWork.bike, emoji: '🚗'),
    Category(name: KeyWork.gas, emoji: '⛽'),
    Category(name: KeyWork.clothing, emoji: '👕'),
    Category(name: KeyWork.gifts, emoji: '🎁'),
    Category(name: KeyWork.entertainment, emoji: '🎞'),
    Category(name: KeyWork.tech, emoji: '📱'),
    Category(name: KeyWork.travel, emoji: '🏝'),
    Category(name: KeyWork.health, emoji: '💊'),
    Category(name: KeyWork.family, emoji: '👪'),
    Category(name: KeyWork.coffee, emoji: '☕'),
  ];

  @override
  List<Object?> get props => [name, id, emoji];

  Category copyWith({
    int? id,
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
