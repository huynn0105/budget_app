import 'package:budget_app/core/database/daos/payment_dao.dart';
import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/core/services/interfaces/ipayment_service.dart';
import 'package:budget_app/global/locator.dart';

class PaymentService implements IPaymentService {
  final _paymentDao = locator<PaymentDao>();
  @override
  Future<List<Payment>> getPayments() async {
    final payments = _paymentDao.getAll();
    if (payments.isEmpty) {
      await _paymentDao.insertAll(Payment.paymentsDefault);
    }
    return _paymentDao.getAll().where((x) => x.active).toList();
  }

  @override
  Future<void> insertPayment(Payment payment) async {
    await _paymentDao.insert(payment);
  }

  @override
  Payment? findPaymentById(String id) {
    return _paymentDao.findById(id);
  }

  @override
  Future<void> deletePayment(Payment payment) async {
    //_paymentDao.delete(payment.id);
    // active = false => Soft Delete
    await _paymentDao.update(payment.id, payment.copyWith(active: false));
  }

  @override
  Future<void> clear() async {
    await _paymentDao.clear();
  }
}
