part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class BudgetStarted extends BudgetEvent {
  const BudgetStarted();

  @override
  List<Object> get props => [];
}

class BudgetChanged extends BudgetEvent {
  final Budget budget;
  const BudgetChanged({required this.budget});

  @override
  List<Object> get props => [budget];
}

class BudgetAdded extends BudgetEvent {
  final Budget budget;
  const BudgetAdded({required this.budget});

  @override
  List<Object> get props => [budget];
}
