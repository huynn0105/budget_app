import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';

class CategoryUIModel {
  final Category category;
  final int total;
  final DateTime lastUpdate;
  final Map<DateTime, List<Transaction>> transactions;
  CategoryUIModel({
    required this.category,
    required this.total,
    required this.lastUpdate,
    required this.transactions,
  });
}
