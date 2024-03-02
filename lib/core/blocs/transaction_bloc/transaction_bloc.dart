import 'package:expense_manager/core/services/interfaces/isetting_service.dart';
import 'package:expense_manager/core/utils/datetime_util.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expense_manager/core/entities/payment_entity.dart';
import 'package:expense_manager/core/entities/category_entity.dart';
import 'package:expense_manager/core/entities/transaction_entity.dart';
import 'package:expense_manager/core/services/interfaces/itransaction_service.dart';
import 'package:expense_manager/global/locator.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final _transactionService = locator<ITransactionService>();
  final _settingService = locator<ISettingService>();
  TransactionBloc() : super(const TransactionInitial()) {
    on<TransactionStarted>((event, emit) {
      final transactions = _transactionService.getTransactions();
      transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      emit(TransactionLoaded(transactions: transactions));
    });
    on<TransactionAdded>((event, emit) {
      final state = this.state;
      if (state is TransactionLoaded) {
        event.transaction.category.target = event.category;
        event.transaction.payment.target = event.payment;
        event.transaction.account.target =
            _settingService.getCurrentSetting().budget.target;
        _transactionService.insertTransaction(event.transaction);
        final transactions = _transactionService.getTransactions();
        transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        emit(TransactionLoaded(transactions: transactions));
      }
    });
    on<TransactionDeleted>((event, emit) {
      final state = this.state;
      if (state is TransactionLoaded) {
        _transactionService.deleteTransaction(event.transaction);
        final transactions = _transactionService.getTransactions();
        transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        emit(TransactionLoaded(transactions: transactions));
      }
    });
    on<TransactionChangeList>(
      (event, emit) => emit(
        TransactionLoaded(transactions: event.transactions),
      ),
    );
    on<TransactionClear>((event, emit) {
      _transactionService.removeTransactionInBudget();
      emit(TransactionLoaded(transactions: []));
    });
  }
}
