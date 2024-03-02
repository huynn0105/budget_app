// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:expense_manager/core/entities/transaction_entity.dart';
import 'package:expense_manager/translation/keyword.dart';

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
    Category(name: KeyWork.food, emoji: '🥗'),
    Category(name: "Car", emoji: '🏎️'),
    Category(name: 'Game', emoji: '🎮'),
    Category(name: KeyWork.coffee, emoji: '☕'),
    Category(name: KeyWork.clothing, emoji: '👔'),
    Category(name: KeyWork.gifts, emoji: '🛍️'),
    Category(name: KeyWork.tech, emoji: '📱'),
    Category(name: KeyWork.travel, emoji: '🏝'),
    Category(name: KeyWork.health, emoji: '💊'),
    Category(name: KeyWork.family, emoji: '👪'),
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
