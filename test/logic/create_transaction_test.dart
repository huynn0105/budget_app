import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/services/interfaces/ipayment_service.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/core/services/interfaces/itransaction_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await setupLocator();
  // này là unit
  // viết thử thôi
  group('Transaction test', () {
    final transactionService = locator<ITransactionService>();
    test(
        'User created transaction, transactions list should add new transaction',
        () {
      final transaction =
          Transaction(note: 'title', dateTime: DateTime.now(), amount: 1);
      final category = Category(name: 'food', emoji: 'food');
      final account = Payment(name: 'cash', emoji: 'cash');
      transaction.category.target = category;
      transaction.payment.target = account;
      transactionService.clear();
      int transactionId = transactionService.insertTransaction(transaction);
      List<Transaction> transactions = transactionService.getTransactions();
      expect(transaction.id, transactionId);
      expect(transaction, transactions.first);
    });
  });

  group('Category test', () {
    final categoryService = locator<ICategoryService>();
    test('User created category, categorys list should add new category', () {
      final category = Category(name: 'food', emoji: 'food');
      int categoryId = categoryService.insertCategory(category);
      Category? categoryInDb = categoryService.findCategoryById(categoryId);
      expect(category.id, categoryId);
      expect(category, categoryInDb);
    });
    test('User delete category, categories list shouldn delete this category',
        () {
      final categories = categoryService.getCategories();
      final categoryInList = categories.first;
      categoryService.deleteCategory(categoryInList);
      Category? categoryInDb =
          categoryService.findCategoryById(categoryInList.id);
      expect(null, categoryInDb);
    });
  });

  group('Account test', () {
    final accountService = locator<IPaymentService>();
    test('User created account, accounts list should add new account', () {
      final account = Payment(name: 'food', emoji: 'food');
      int accountId = accountService.insertPayment(account);
      Payment? accountInDb = accountService.findPaymentById(accountId);
      expect(account.id, accountId);
      expect(account, accountInDb);
    });
    test('User delete account, accounts list shouldn delete this account', () {
      final accounts = accountService.getPayments();
      final accountInList = accounts.first;
      accountService.deletePayment(accountInList);
      Payment? accountInDb = accountService.findPaymentById(accountInList.id);
      expect(null, accountInDb);
    });
  });
}
