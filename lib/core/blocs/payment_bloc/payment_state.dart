part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object?> get props => [];
}

class PaymentLoaded extends PaymentState {
  final List<Payment> payments;
  final Payment paymentSelected;
  const PaymentLoaded({
    required this.paymentSelected,
    required this.payments,
  });
  @override
  List<Object?> get props => [payments, paymentSelected];
}

class PaymentError extends PaymentState {
  @override
  List<Object?> get props => [];
}
