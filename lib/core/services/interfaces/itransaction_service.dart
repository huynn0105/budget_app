import 'package:budget_app/core/entities/transaction_entity.dart';

abstract class ITransactionService {
  int insertTransaction(Transaction transaction);
  void deleteTransaction(Transaction transaction);
  List<Transaction> getTransactions();
  Transaction? getTransactionById(int id);
  void clear();
  List<Transaction> getWeekTransactions(DateTime date);
  List<Transaction> getYearTransactions(DateTime date);
  List<Transaction> getMonthTransactions(DateTime date);
}
