import 'package:budget_app/core/entities/transaction_entity.dart';
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
    Category(name: 'Food', emoji: '🥙'),
    Category(name: 'Breakfash', emoji: '🍔'),
    Category(name: 'Lunch', emoji: '🍜'),
    Category(name: 'Dinner', emoji: '🍽'),
    Category(name: 'Drink', emoji: '🍹'),
    Category(name: 'Bike', emoji: '🚗'),
    Category(name: 'Gas', emoji: '⛽'),
    Category(name: 'Clothing', emoji: '👕'),
    Category(name: 'Gifts', emoji: '🎁'),
    Category(name: 'Entertainment', emoji: '🎞'),
    Category(name: 'Tech', emoji: '📱'),
    Category(name: 'Travel', emoji: '🏝'),
    Category(name: 'Health', emoji: '💊'),
    Category(name: 'Family', emoji: '👪'),
    Category(name: 'Coffe', emoji: '☕'),
  ];

  @override
  List<Object?> get props => [name, id, emoji];
}
