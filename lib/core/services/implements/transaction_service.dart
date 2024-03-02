import 'package:budget_app/core/database/daos/transaction_dao.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/global/locator.dart';

class TransactionService implements ITransactionService {
  final _transactionDao = locator<TransactionDao>();

  @override
  Transaction? getTransactionById(String id) {
    return _transactionDao.findById(id);
  }

  @override
  List<Transaction> getTransactions() {
    return _transactionDao.getAll().toList();
  }

  @override
  Future<void> insertTransaction(Transaction transaction) async {
    await _transactionDao.insert(transaction);
  }

  @override
  void clear() {
    _transactionDao.clear();
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) async {
   await _transactionDao.delete(transaction.id);
  }

  @override
  List<Transaction> getWeekTransactions(DateTime date) {
    final startOfWeek = date.startOfWeek().millisecondsSinceEpoch;
    final endOfWeek = date.endOfWeek().millisecondsSinceEpoch;
    final transactions = getTransactions()
        .where((x) =>
            x.dateTime.millisecondsSinceEpoch >= startOfWeek &&
            x.dateTime.millisecondsSinceEpoch <= endOfWeek)
        .toList();
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return transactions;
  }

  @override
  List<Transaction> getYearTransactions(DateTime date) {
    final transactions = getTransactions();
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return transactions;
  }

  @override
  List<Transaction> getMonthTransactions(DateTime date) {
    final first = date.firstDayOfMonth().millisecondsSinceEpoch;
    final end = date.endOfWeek().millisecondsSinceEpoch;
    final transactions = getTransactions()
        .where((x) =>
            x.dateTime.millisecondsSinceEpoch >= first &&
            x.dateTime.millisecondsSinceEpoch <= end)
        .toList();
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return transactions;
  }

  @override
  void removeTransactionInBudget() {
    final transactionsInBudget = getTransactions();
    _transactionDao.deleteAll(transactionsInBudget.map((e) => e.id).toList());
  }
}
