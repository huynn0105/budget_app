import 'package:budget_app/core/entities/payment_entity.dart';

abstract class IPaymentService {
  List<Payment> getPayments();
  Payment? findPaymentById(int id);
  int insertPayment(Payment account);
  void deletePayment(Payment account);
  void clear();
}
