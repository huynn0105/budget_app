import 'package:budget_app/core/entities/transaction_entity.dart';

abstract class ITransactionService {
  Future<void> insertTransaction(Transaction transaction);
  Future<void> deleteTransaction(Transaction transaction);
  List<Transaction> getTransactions();
  Transaction? getTransactionById(String id);
  void clear();
  void removeTransactionInBudget();
  List<Transaction> getWeekTransactions(DateTime date);
  List<Transaction> getYearTransactions(DateTime date);
  List<Transaction> getMonthTransactions(DateTime date);
}
