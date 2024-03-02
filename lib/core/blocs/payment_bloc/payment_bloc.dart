import 'package:equatable/equatable.dart';

import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/core/services/interfaces/ipayment_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final _paymentService = locator<IPaymentService>();

  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentStarted>((event, emit) async {
      final payments = await _paymentService.getPayments();
      emit(
        PaymentLoaded(
          payments: payments,
          paymentSelected: payments.first,
        ),
      );
    });
    on<PaymentAdded>((event, emit) async {
      final state = this.state;
      if (state is PaymentLoaded) {
        await _paymentService.insertPayment(event.payment);
        final payments = await _paymentService.getPayments();
        emit(
          PaymentLoaded(
            payments: payments,
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
    on<PaymentDeleted>((event, emit) async {
      final state = this.state;
      if (state is PaymentLoaded) {
        _paymentService.deletePayment(event.payment);
        final payments = await _paymentService.getPayments();

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
    on<PaymentClear>((event, emit) async {
      _paymentService.clear();
      final payments = await _paymentService.getPayments();
      emit(PaymentLoaded(paymentSelected: payments.first, payments: payments));
    });
  }
}
