import 'package:budget_app/core/entities/payment_entity.dart';

abstract class IPaymentService {
  Future<List<Payment>> getPayments();
  Payment? findPaymentById(String id);
  Future<void> insertPayment(Payment account);
  Future<void> deletePayment(Payment account);
  Future<void> clear();
}
