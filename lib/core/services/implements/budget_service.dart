import 'package:budget_app/core/database/daos/budget_dao.dart';
import 'package:budget_app/core/entities/budget_entity.dart';
import 'package:budget_app/core/services/interfaces/ibudget_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:budget_app/translation/keyword.dart';
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
      _accountDao.insert(Budget(
          name: KeyWork.myBudget.tr,
          image: '🧍',
          createTime: DateTime.now(),
          id: ''));
    }

    return _accountDao.getAll();
  }

  @override
  void insertAccount(Budget account) {
    _accountDao.insert(account);
  }
}
