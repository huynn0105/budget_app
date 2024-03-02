import 'package:bloc/bloc.dart';
import 'package:budget_app/core/entities/budget_entity.dart';
import 'package:budget_app/core/services/interfaces/ibudget_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:equatable/equatable.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final _budgetService = locator<IBudgetService>();
  BudgetBloc() : super(BudgetInitial()) {
    on<BudgetStarted>((event, emit) {
      emit(
        BudgetLoaded(
          budgets: _budgetService.getAllAccounts(),
          currentBudget: _budgetService.getAllAccounts().first,
        ),
      );
    });
    on<BudgetChanged>((event, emit) {
      final state = this.state;
      if (state is BudgetLoaded) {
        emit(state.copyWith(currentBudget: event.budget));
      }
    });
    on<BudgetRemoved>((event, emit) {
      _budgetService.deleteAccount(event.budget);
      final budgets = _budgetService.getAllAccounts();
      emit(
        BudgetLoaded(
          budgets: budgets,
          currentBudget: _budgetService.getAllAccounts().first,
        ),
      );
    });
    on<BudgetAdded>((event, emit) {
      _budgetService.insertAccount(event.budget);
      if (state is BudgetLoaded) {
        emit(
          BudgetLoaded(
            budgets: _budgetService.getAllAccounts(),
            currentBudget: event.budget,
          ),
        );
      }
    });
  }
}
