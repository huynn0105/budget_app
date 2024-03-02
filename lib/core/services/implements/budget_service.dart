import 'package:expense_manager/core/database/daos/budget_dao.dart';
import 'package:expense_manager/core/entities/budget_entity.dart';
import 'package:expense_manager/core/services/interfaces/ibudget_service.dart';
import 'package:expense_manager/global/locator.dart';
import 'package:expense_manager/translation/keyword.dart';
import 'package:get/get.dart';

class AccountService implements IBudgetService {
  final _accountDao = locator<BudgetDao>();

  @override
  void deleteAccount(Budget account) {
    _accountDao.delete(account.id);
  }

  @override
  List<Budget> getAllAccounts() {
    final accounts = _accountDao.getAll();
    if (accounts.isEmpty) {
      _accountDao.insert(Budget(name: KeyWork.myBudget.tr, image: '🧍'));
    }

    return _accountDao.getAll();
  }

  @override
  int insertAccount(Budget account) {
    return _accountDao.insert(account);
  }
}
