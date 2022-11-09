part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();
  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {
  const BudgetInitial();
}

class BudgetLoaded extends BudgetState {
  final List<Budget> budgets;
  final Budget currentBudget;
  const BudgetLoaded({
    required this.budgets,
    required this.currentBudget,
  });

  @override
  List<Object> get props => [
        budgets,
        currentBudget,
      ];

  BudgetLoaded copyWith({
    List<Budget>? budgets,
    Budget? currentBudget,
  }) {
    return BudgetLoaded(
      budgets: budgets ?? this.budgets,
      currentBudget: currentBudget ?? this.currentBudget,
    );
  }
}
