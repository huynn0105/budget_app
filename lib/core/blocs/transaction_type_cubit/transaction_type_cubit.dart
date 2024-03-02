import 'package:expense_manager/core/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_type_state.dart';

class TransactionTypeCubit extends Cubit<TransactionTypeState> {
  TransactionTypeCubit() : super(const TransactionTypeState());

  void changeTransactionType(TransactionType transactionType) {
    if (transactionType != state.transactionType) {
      emit(state.copyWith(transactionType: transactionType));
    }
  }
}
