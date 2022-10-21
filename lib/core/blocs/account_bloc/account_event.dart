part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccountStarted extends AccountEvent {
  const AccountStarted();
  @override
  List<Object?> get props => [];
}

class AccountAdded extends AccountEvent {
  final Account account;
  const AccountAdded({required this.account});
  @override
  List<Object?> get props => [account];
}

class AccountSelected extends AccountEvent {
  final Account account;
  const AccountSelected({required this.account});
  @override
  List<Object?> get props => [account];
}

class AccountDeleted extends AccountEvent {
  final Account account;
  const AccountDeleted({required this.account});
  @override
  List<Object?> get props => [account];
}

class AccountClear extends AccountEvent {
  const AccountClear();
  @override
  List<Object?> get props => [];
}