part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  @override
  List<Object?> get props => [];
}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  const TransactionLoaded({
    required this.transactions,
  });
  int get total => transactions.fold(0, (prevValue, x) => prevValue + x.amount);

  Map<DateTime, List<Transaction>> get transactionOfDate {
    return transactions.groupListsBy<DateTime>((x) => x.dateTime.toDate());
  }

  int getTotal(List<Transaction> transactions) {
    return transactions.fold(0, (prevValue, x) => prevValue + x.amount);
  }

  @override
  List<Object?> get props => [transactions];
}

class TransactionError extends TransactionState {
  @override
  List<Object?> get props => [];
}

