import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';

class TransactionUIModel extends Equatable {
  final List<Transaction> transactions;
  final DateTime date;
  const TransactionUIModel({
    required this.transactions,
    required this.date,
  });

  @override
  List<Object?> get props => [transactions, date];
}
