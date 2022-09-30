import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:budget_app/global/locator.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final _transactionService = locator<ITransactionService>();
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionStarted>((event, emit) {
      final transactions = _transactionService.getTransactions();
      emit(TransactionLoaded(transactions: transactions));
    });
    on<TransactionAdded>((event, emit) {
      final state = this.state;
      if (state is TransactionLoaded) {
        event.transaction.category.target = event.category;
        event.transaction.account.target = event.account;
        _transactionService.insertTransaction(event.transaction);
        emit(TransactionLoaded(
            transactions: [...state.transactions, event.transaction]));
      }
    });
  }
}
