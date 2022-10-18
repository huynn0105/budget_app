import 'package:budget_app/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/account_bloc/account_bloc.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/blocs/transaction_type_cubit/transaction_type_cubit.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/ui/add_new_account_screen.dart';
import 'package:budget_app/ui/add_new_category_screen.dart';

part 'widgets/account_bottom_sheet.dart';
part 'widgets/add_button.dart';
part 'widgets/button.dart';
part 'widgets/category_bottom_sheet.dart';
part 'widgets/money_text_field.dart';
part 'widgets/save_button.dart';

class AddNewTransactionScreen extends StatefulWidget {
  const AddNewTransactionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewTransactionScreen> createState() =>
      _AddNewTransactionScreenState();
}

class _AddNewTransactionScreenState extends State<AddNewTransactionScreen> {
  late TextEditingController controller, noteController;
  late AccountBloc accountBloc;
  late CategoryBloc categoryBloc;
  late TransactionBloc transactionBloc;
  late TransactionTypeCubit transactionTypeCubit;
  @override
  void initState() {
    controller = TextEditingController(text: '0đ');
    noteController = TextEditingController();
    accountBloc = context.read<AccountBloc>();

    categoryBloc = context.read<CategoryBloc>();
    transactionBloc = context.read<TransactionBloc>();
    transactionTypeCubit = context.read<TransactionTypeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        leading: TextButton(
          child: Text(
            KeyWork.cancel.tr,
            style: TextStyleUtils.medium(16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextButton(
          child: BlocBuilder<TransactionTypeCubit, TransactionTypeState>(
            builder: (context, state) {
              return Text(
                state.transactionType == TransactionType.expense
                    ? KeyWork.expense.tr
                    : KeyWork.income.tr,
                style: TextStyleUtils.medium(16),
              );
            },
          ),
          onPressed: () {
            showMenu(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                position: RelativeRect.fromLTRB(1.sw / 3,
                    AppBar().preferredSize.height + 20.h, 1.sw / 2, 0),
                items: TransactionType.values
                    .map(
                      (e) => PopupMenuItem<String>(
                        value: e.name,
                        child: Text(
                          e == TransactionType.expense ?  KeyWork.expense.tr :  KeyWork.income.tr,
                        ),
                        onTap: () {
                          context
                              .read<TransactionTypeCubit>()
                              .changeTransactionType(e);
                        },
                      ),
                    )
                    .toList());
          },
        ),
        centerTitle: true,
        leadingWidth: 80.w,
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: IntrinsicWidth(
                    child: _MoneyTextField(
                      controller: controller,
                      key: const Key('moneyTextField'),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                IntrinsicWidth(
                  child: TextField(
                    controller: noteController,
                    key: const Key('noteTextField'),
                    style: TextStyleUtils.regular(14),
                    decoration: InputDecoration(
                      hintText:  KeyWork.enterNote.tr,
                      hintStyle: TextStyleUtils.regular(14),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const _AccountBottomSheet();
                      },
                    );
                  },
                  child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      if (state is AccountInitial) {
                        return const CircularProgressIndicator();
                      }
                      if (state is AccountLoaded) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${state.accountSelected.emoji} ',
                                style: TextStyleUtils.regular(28)),
                            Text(
                              state.accountSelected.name.tr,
                              style: TextStyleUtils.medium(16),
                            ),
                          ],
                        );
                      }
                      return const Text('Something went wrong!');
                    },
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_right_alt,
                size: 30,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const CategoriesBottomSheet();
                      },
                    );
                  },
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryInitial) {
                        return const CircularProgressIndicator();
                      }
                      if (state is CategoryLoaded) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${state.categorySelected.emoji} ',
                                  style: TextStyleUtils.regular(28)),
                              Text(
                                state.categorySelected.name.tr,
                                style: TextStyleUtils.medium(16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        );
                      }
                      return const Text('Something went wrong!');
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              _SaveButton(
                onPressed: () {
                  transactionBloc.add(
                    TransactionAdded(
                      transaction: Transaction(
                        amount: int.parse(controller.text
                            .replaceAll(',', '')
                            .replaceAll('đ', '')),
                        dateTime: DateTime.now(),
                        title: noteController.text,
                        type: transactionTypeCubit.state.transactionType,
                      ),
                      account:
                          (accountBloc.state as AccountLoaded).accountSelected,
                      category: (categoryBloc.state as CategoryLoaded)
                          .categorySelected,
                    ),
                  );
                  context.read<AnalysisBloc>().add(const AnalysisStarted());
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(height: 1.sh / 2),
    );
  }
}
