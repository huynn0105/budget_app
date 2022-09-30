import 'package:equatable/equatable.dart';

import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/services/interfaces/iaccount_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final _accountService = locator<IAccountService>();

  AccountBloc() : super(AccountInitial()) {
    on<AccountStarted>((event, emit) {
      final accounts = _accountService.getAccounts();
      emit(
        AccountLoaded(
          accounts: accounts,
          accountSelected: accounts.first,
        ),
      );
    });
    on<AccountAdded>((event, emit) {
      final state = this.state;
      if (state is AccountLoaded) {
        _accountService.insertAccount(event.account);
        emit(
          AccountLoaded(
            accounts: [...state.accounts, event.account],
            accountSelected: event.account,
          ),
        );
      }
    });
    on<AccountSelected>((event, emit) {
      final state = this.state;
      if (state is AccountLoaded) {
        emit(
          AccountLoaded(
            accountSelected: event.account,
            accounts: state.accounts,
          ),
        );
      }
    });
    on<AccountDeleted>((event, emit) {
      final state = this.state;
      if (state is AccountLoaded) {
        _accountService.deleteAccount(event.account);
        emit(
          AccountLoaded(
            accounts: [...state.accounts]..remove(event.account),
            accountSelected: state.accountSelected.id == event.account.id
                ? state.accounts.first
                : event.account,
          ),
        );
      }
    });
  }
}
