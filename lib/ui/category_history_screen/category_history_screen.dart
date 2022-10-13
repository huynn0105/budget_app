import 'package:budget_app/constants.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/ui_model/category_ui_model.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
part 'widgets/transaction_of_date.dart';

class CategoryHistoryScreen extends StatelessWidget {
  final CategoryUIModel categoryUIModel;
  const CategoryHistoryScreen({
    super.key,
    required this.categoryUIModel,
  });

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black87,
        ),
      ),
      body: Column(
        children: [
          Text(
            'Spent this ${categoryUIModel.category.name} ${categoryUIModel.category.emoji}',
            style: TextStyleUtils.regular(17).copyWith(color: Colors.black54),
          ),
          SizedBox(height: 5.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: format.format(categoryUIModel.total),
                  style: TextStyleUtils.regular(45).copyWith(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'đ',
                  style: TextStyleUtils.regular(20)
                      .copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          Expanded(
            child: ListView(
              children: categoryUIModel.transactions.entries
                  .map((e) =>
                      _TransactionOfDate(date: e.key, transactions: e.value))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
