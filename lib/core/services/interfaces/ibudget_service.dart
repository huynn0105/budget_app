import 'package:budget_app/core/entities/budget_entity.dart';

abstract class IBudgetService {
  List<Budget> getAllAccounts();
  void insertAccount(Budget account);
  void deleteAccount(Budget account);

}
