part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class TransactionStarted extends TransactionEvent {
  @override
  List<Object> get props => [];
}

class TransactionAdded extends TransactionEvent {
  final Transaction transaction;
  final Category category;
  final Account account;

  const TransactionAdded({
    required this.transaction,
    required this.account,
    required this.category,
  });

  @override
  List<Object?> get props => [transaction];
}
