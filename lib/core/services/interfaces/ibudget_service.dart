import 'package:expense_manager/core/entities/budget_entity.dart';

abstract class IBudgetService {
  List<Budget> getAllAccounts();
  int insertAccount(Budget account);
  void deleteAccount(Budget account);
}
