import 'package:equatable/equatable.dart';

import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/core/services/interfaces/iaccount_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final _paymentService = locator<IAccountService>();

  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentStarted>((event, emit) {
      final payments = _paymentService.getPayments();
      emit(
        PaymentLoaded(
          payments: payments,
          paymentSelected: payments.first,
        ),
      );
    });
    on<PaymentAdded>((event, emit) {
      final state = this.state;
      if (state is PaymentLoaded) {
        _paymentService.insertAccount(event.payment);
        emit(
          PaymentLoaded(
            payments: _paymentService.getPayments(),
            paymentSelected: event.payment,
          ),
        );
      }
    });
    on<PaymentSelected>((event, emit) {
      final state = this.state;
      if (state is PaymentLoaded) {
        emit(
          PaymentLoaded(
            paymentSelected: event.payment,
            payments: state.payments,
          ),
        );
      }
    });
    on<PaymentDeleted>((event, emit) {
      final state = this.state;
      if (state is PaymentLoaded) {
        _paymentService.deletePayment(event.payment);
        final payments = _paymentService.getPayments();

        emit(
          PaymentLoaded(
            payments: payments,
            paymentSelected: state.paymentSelected.id == event.payment.id
                ? payments.first
                : event.payment,
          ),
        );
      }
    });
    on<PaymentClear>((event, emit) {
      _paymentService.clear();
      final payments = _paymentService.getPayments();
      emit(PaymentLoaded(paymentSelected: payments.first, payments: payments));
    });
  }
}
