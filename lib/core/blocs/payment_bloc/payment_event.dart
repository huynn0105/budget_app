part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class PaymentStarted extends PaymentEvent {
  const PaymentStarted();
  @override
  List<Object?> get props => [];
}

class PaymentAdded extends PaymentEvent {
  final Payment payment;
  const PaymentAdded({required this.payment});
  @override
  List<Object?> get props => [payment];
}

class PaymentSelected extends PaymentEvent {
  final Payment payment;
  const PaymentSelected({required this.payment});
  @override
  List<Object?> get props => [payment];
}

class PaymentDeleted extends PaymentEvent {
  final Payment payment;
  const PaymentDeleted({required this.payment});
  @override
  List<Object?> get props => [payment];
}

class PaymentClear extends PaymentEvent {
  const PaymentClear();
  @override
  List<Object?> get props => [];
}
