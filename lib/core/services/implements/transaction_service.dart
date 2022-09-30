import 'package:budget_app/core/database/daos/transaction_dao.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:budget_app/global/locator.dart';

class TransactionService implements ITransactionService {
  final _transactionDao = locator<TransactionDao>();

  @override
  Transaction? getTransactionById(int id) {
    return _transactionDao.findById(id);
  }

  @override
  List<Transaction> getTransactions() {
    return _transactionDao.getAll();
  }

  @override
  void insertTransaction(Transaction transaction) {
    _transactionDao.insert(transaction);
  }
}
