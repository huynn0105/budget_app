import 'package:budget_app/core/database/daos/payment_dao.dart';
import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/core/services/interfaces/iaccount_service.dart';
import 'package:budget_app/global/locator.dart';

class AccountService implements IAccountService {
  final _paymentDao = locator<PaymentDao>();
  @override
  List<Payment> getPayments() {
    final payments = _paymentDao.getAll();
    if (payments.isEmpty) {
      _paymentDao.insertAll(Payment.paymentsDefault);
    }
    return _paymentDao.getAll().where((x) => x.active).toList();
  }

  @override
  int insertAccount(Payment payment) {
    return _paymentDao.insert(payment);
  }

  @override
  Payment? findAccountById(int id) {
    return _paymentDao.findById(id);
  }

  @override
  void deletePayment(Payment payment) {
    //_paymentDao.delete(payment.id);
    // active = false => Soft Delete
    _paymentDao.update(payment.copyWith(active: false));
  }

  @override
  void clear() {
    _paymentDao.deleteAll();
  }
}
