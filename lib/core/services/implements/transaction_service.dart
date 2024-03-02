import 'package:expense_manager/core/database/daos/setting_dao.dart';
import 'package:expense_manager/core/database/daos/transaction_dao.dart';
import 'package:expense_manager/core/entities/transaction_entity.dart';
import 'package:expense_manager/core/services/interfaces/itransaction_service.dart';
import 'package:expense_manager/core/utils/datetime_util.dart';
import 'package:expense_manager/global/locator.dart';

class TransactionService implements ITransactionService {
  final _transactionDao = locator<TransactionDao>();
  final _settingDao = locator<SettingDao>();

  @override
  Transaction? getTransactionById(int id) {
    return _transactionDao.findById(id);
  }

  @override
  List<Transaction> getTransactions() {
    return _settingDao.getCurrentSetting().budget.target!.transactions.toList();
  }

  @override
  int insertTransaction(Transaction transaction) {
    return _transactionDao.insert(transaction);
  }

  @override
  void clear() {
    _transactionDao.deleteAll();
  }

  @override
  void deleteTransaction(Transaction transaction) {
    _transactionDao.delete(transaction.id);
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
    _transactionDao.removeMany(transactionsInBudget.map((e) => e.id).toList());
  }
}
