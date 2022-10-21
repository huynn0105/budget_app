import 'package:budget_app/core/entities/account_entity.dart';

abstract class IAccountService {
  List<Account> getAccounts();
  Account? findAccountById(int id);
  int insertAccount(Account account);
  void deleteAccount(Account account);
  void clear();
}
