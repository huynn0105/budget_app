import 'package:budget_app/core/entities/payment_entity.dart';

abstract class IAccountService {
  List<Payment> getPayments();
  Payment? findAccountById(int id);
  int insertAccount(Payment account);
  void deletePayment(Payment account);
  void clear();
}
