import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import 'base_entity.dart';

@Entity()
class Category extends BaseEntity {
  @override
  int id = 0;
  final String emoji;
  final String name;

  @Backlink()
  final transactions = ToMany<Transaction>();
  Category({
    required this.name,
    required this.emoji,
  });

  static List<Category> cetegoriesDefault = [
    Category(name: KeyWork.food, emoji: '🥙'),
    Category(name: KeyWork.breakfash, emoji: '🍔'),
    Category(name: KeyWork.lunch, emoji: '🍜'),
    Category(name: KeyWork.dinner, emoji: '🍽'),
    Category(name: KeyWork.drink, emoji: '🍹'),
    Category(name: KeyWork.bike, emoji: '🚗'),
    Category(name: KeyWork.gas, emoji: '⛽'),
    Category(name: KeyWork.clothing, emoji: '👕'),
    Category(name: KeyWork.gifts, emoji: '🎁'),
    Category(name: KeyWork.entertainment, emoji: '🎞'),
    Category(name: KeyWork.tech, emoji: '📱'),
    Category(name: KeyWork.travel, emoji: '🏝'),
    Category(name: KeyWork.health, emoji: '💊'),
    Category(name: KeyWork.family, emoji: '👪'),
    Category(name: KeyWork.coffe, emoji: '☕'),
  ];

  @override
  List<Object?> get props => [name, id, emoji];
}
