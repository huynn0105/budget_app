import 'package:bloc_test/bloc_test.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  group('Transaction Bloc Testing', () {
    late TransactionBloc transactionBloc;
    final transactionService = locator<ITransactionService>();

    setUp(() async {
      transactionBloc = TransactionBloc();
    });

    test('Initial Test', () {
      expect(transactionBloc.state, const TransactionInitial());
    });

    blocTest<TransactionBloc, TransactionState>(
        'emit [TransactionLoaded(transactions)] when TransactionStarted is added',
        build: () => transactionBloc,
        act: (bloc) => bloc.add(TransactionStarted()),
        expect: () => [
              TransactionLoaded(
                  transactions: transactionService.getTransactions())
            ]);

    blocTest<TransactionBloc, TransactionState>(
      'emit [TransactionLoaded(transactions)] when TransactionAdded is added',
      setUp: () {
        transactionBloc.add(TransactionStarted());
      },
      build: () => transactionBloc,
      act: (bloc) => bloc.add(
        TransactionAdded(
          transaction:
              Transaction(title: 'title', dateTime: DateTime.now(), amount: 1),
          account: Account(
            emoji: 'cash',
            name: 'cash',
          ),
          // mn sôi nổi nhỉ

          category: Category(
            emoji: 'food',
            name: 'food',
          ),
        ),
      ),
      expect: () => [
        TransactionLoaded(transactions: transactionService.getTransactions()),
      ],
    );
  });

  group('Category bloc test', () {
    late CategoryBloc categoryBloc;
    final categoryService = locator<ICategoryService>();
    setUp(() {
      categoryBloc = CategoryBloc();
    });

    test('Initial Test', () {
      expect(categoryBloc.state, const CategoryInitial());
    });

    blocTest<CategoryBloc,CategoryState>(
        'emit [CategoryLoaded(categories,categorySelected) when CategoryStarted is added]',
        build: () => categoryBloc,
        act: (bloc) => bloc.add(const CategoryStarted()),
        expect: () {
          final categories = categoryService.getCategoris();
          return [
            CategoryLoaded(
                categories: categories, categorySelected: categories.first)
          ];
        });
    blocTest<CategoryBloc,CategoryState>(
        'emit [CategoryLoaded(categories,categorySelected) when CategoryAdded is added]',
        build: () => categoryBloc,
        setUp: () => categoryBloc.add(const CategoryStarted()),
        act: (bloc) => bloc.add(
            CategoryAdded(category: Category(emoji: 'food', name: 'food'))),
        expect: () {
          final categories = categoryService.getCategoris();
          return [
            CategoryLoaded(
                categories: categories,
                categorySelected:
                    (categoryBloc.state as CategoryLoaded).categorySelected)
          ];
        });

    blocTest<CategoryBloc,CategoryState>(
        'emit [CategoryLoaded(categories,categorySelected) when CategorySelected is added]',
        build: () => categoryBloc,
        setUp: () {
          categoryBloc.add(const CategoryStarted());
        },
        act: (bloc) => bloc
            .add(CategorySelected(category: Category.cetegoriesDefault.first)),
        expect: () {
          final categories = categoryService.getCategoris();
          return [
            CategoryLoaded(
                categories: categories,
                categorySelected: Category.cetegoriesDefault.first)
          ];
        });
  });
}
