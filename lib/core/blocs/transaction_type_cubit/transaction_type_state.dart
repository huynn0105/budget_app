// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_type_cubit.dart';

class TransactionTypeState extends Equatable {
  final TransactionType transactionType;

  const TransactionTypeState({
    this.transactionType = TransactionType.expense,
  });

  @override
  List<Object> get props => [transactionType];

  TransactionTypeState copyWith({
    TransactionType? transactionType,
  }) {
    return TransactionTypeState(
      transactionType: transactionType ?? this.transactionType,
    );
  }
}
