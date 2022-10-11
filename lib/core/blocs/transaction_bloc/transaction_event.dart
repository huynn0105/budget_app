part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class TransactionStarted extends TransactionEvent {
  const TransactionStarted();
  @override
  List<Object> get props => [];
}

class TransactionChangeList extends TransactionEvent {
  final List<Transaction> transactions;
  const TransactionChangeList({required this.transactions});
  @override
  List<Object> get props => [transactions];
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

class TransactionDeleted extends TransactionEvent {
  final Transaction transaction;
  const TransactionDeleted({required this.transaction});
  @override
  List<Object> get props => [transaction];
}
