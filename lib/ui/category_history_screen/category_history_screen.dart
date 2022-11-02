import 'package:budget_app/constants.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/ui_model/category_ui_model.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../core/blocs/setting_bloc/setting_bloc.dart';

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
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            '${KeyWork.spent.tr} ${categoryUIModel.category.name.tr} ${categoryUIModel.category.emoji}',
            style: TextStyleUtils.regular(17),
          ),
          SizedBox(height: 5.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: format.format(categoryUIModel.total),
                  style: TextStyleUtils.regular(45).copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextSpan(
                  text: 'đ',
                  style: TextStyleUtils.regular(20).copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
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
