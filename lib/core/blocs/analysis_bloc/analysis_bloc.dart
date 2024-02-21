import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/ui_model/category_ui_model.dart';
import 'package:budget_app/core/ui_model/transaction_ui_model.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/global/locator.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final _transactionService = locator<ITransactionService>();

  AnalysisBloc() : super(const AnalysisInitial()) {
    on<AnalysisStarted>((event, emit) {
      ViewType viewType = ViewType.year;
      final state = this.state;
      if (state is AnalysisLoaded) {
        viewType = state.viewType;
      }
      final today = DateTime.now().toStartDate();
      List<Transaction> transactionOfWeek =
          _transactionService.getWeekTransactions(today);
      List<Transaction> transactionOfMonth =
          _transactionService.getMonthTransactions(today);
      List<Transaction> transactionOfYear =
          _transactionService.getYearTransactions(today);
      emit(
        AnalysisLoaded(
          viewType: viewType,
          transactionOfMonth:
              TransactionUIModel(date: today, transactions: transactionOfMonth),
          transactionOfWeek:
              TransactionUIModel(date: today, transactions: transactionOfWeek),
          transactionOfYear:
              TransactionUIModel(date: today, transactions: transactionOfYear),
        ),
      );
    });
    on<AnalysisSeleteViewType>((event, emit) {
      final state = this.state;
      if (state is AnalysisLoaded) {
        final today = DateTime.now().toStartDate();
        switch (event.viewType) {
          case ViewType.week:
            List<Transaction> transactionOfWeek =
                _transactionService.getWeekTransactions(today);
            emit(state.copyWith(
                viewType: ViewType.week,
                transactionOfWeek: TransactionUIModel(
                    date: today, transactions: transactionOfWeek)));
            break;
          case ViewType.month:
            List<Transaction> transactionOfMonth =
                _transactionService.getMonthTransactions(today);
            emit(state.copyWith(
              viewType: ViewType.month,
              transactionOfMonth: TransactionUIModel(
                  date: today, transactions: transactionOfMonth),
            ));
            break;
          case ViewType.year:
            List<Transaction> transactionOfYear =
                _transactionService.getYearTransactions(today);
            emit(state.copyWith(
              viewType: ViewType.year,
              transactionOfYear: TransactionUIModel(
                  date: today, transactions: transactionOfYear),
            ));
            break;
        }
      }
    });
    on<AnalysisChangeDate>((event, emit) {
      final state = this.state;
      if (state is AnalysisLoaded) {
        switch (event.viewType) {
          case ViewType.week:
            List<Transaction> transactionOfWeek =
                _transactionService.getWeekTransactions(event.date);
            emit(state.copyWith(
                viewType: ViewType.week,
                transactionOfWeek: TransactionUIModel(
                    date: event.date, transactions: transactionOfWeek)));
            break;
          case ViewType.month:
            List<Transaction> transactionOfMonth =
                _transactionService.getMonthTransactions(event.date);
            emit(state.copyWith(
              viewType: ViewType.month,
              transactionOfMonth: TransactionUIModel(
                  date: event.date, transactions: transactionOfMonth),
            ));
            break;
          case ViewType.year:
            List<Transaction> transactionOfMonth =
                _transactionService.getYearTransactions(event.date);
            emit(state.copyWith(
              viewType: ViewType.year,
              transactionOfYear: TransactionUIModel(
                  date: event.date, transactions: transactionOfMonth),
            ));
            break;
        }
      }
    });
  }
}
