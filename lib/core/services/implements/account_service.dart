import 'package:budget_app/core/database/daos/account_dao.dart';
import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/services/interfaces/iaccount_service.dart';
import 'package:budget_app/global/locator.dart';

class AccountService implements IAccountService {
  final _accountDao = locator<AccountDao>();
  @override
  List<Account> getAccounts() {
    final accounts = _accountDao.getAll();
    if (accounts.isEmpty) {
      _accountDao.insertAll(Account.accountsDefault);
    }
    return _accountDao.getAll().where((x) => x.active).toList();
  }

  @override
  int insertAccount(Account account) {
    return _accountDao.insert(account);
  }

  @override
  Account? findAccountById(int id) {
    return _accountDao.findById(id);
  }

  @override
  void deleteAccount(Account account) {
    //_accountDao.delete(account.id);
    // active = false => Soft Delete
    _accountDao.update(account.copyWith(active: false));
  }

  @override
  void clear() {
    _accountDao.deleteAll();
  }
}
