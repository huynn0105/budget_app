part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
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
    return transactions.groupListsBy<DateTime>((x) => x.dateTime.toStartDate());
  }

  int getTotal(List<Transaction> transactions) {
    return transactions.fold(
        0,
        (prevValue, x) =>
            prevValue +
            (x.type == TransactionType.expense ? -x.amount : x.amount));
  }

  int get totalThisWeek {
    final today = DateTime.now();
    final startOfWeek = today.startOfWeek();
    final endOfWeek = today.endOfWeek();
    final transactionsThisWeek = transactions
        .where((x) =>
            x.dateTime.compareTo(startOfWeek) == 1 &&
            x.dateTime.compareTo(endOfWeek) == -1)
        .toList();
    return getTotal(transactionsThisWeek);
  }

  @override
  List<Object?> get props => [transactions];
}

class TransactionError extends TransactionState {
  const TransactionError();
  @override
  List<Object?> get props => [];
}
