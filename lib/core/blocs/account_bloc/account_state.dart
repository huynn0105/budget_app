part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountLoaded extends AccountState {
  final List<Account> accounts;
  final Account accountSelected;
  const AccountLoaded({
    required this.accountSelected,
    required this.accounts,
  });
  @override
  List<Object?> get props => [accounts,accountSelected];
}

class AccountError extends AccountState {
  @override
  List<Object?> get props => [];
}
