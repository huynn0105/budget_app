// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';

class TransactionUIModel {
  Transaction transaction;
  Account account;
  Category category;
  TransactionUIModel({
    required this.transaction,
    required this.account,
    required this.category,
  });
}
