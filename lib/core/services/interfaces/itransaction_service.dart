import 'package:budget_app/core/entities/transaction_entity.dart';

abstract class ITransactionService {
  void insertTransaction(Transaction transaction);
  List<Transaction> getTransactions();
  Transaction? getTransactionById(int id);
}
