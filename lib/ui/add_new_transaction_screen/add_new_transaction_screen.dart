import 'package:expense_manager/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:expense_manager/core/blocs/payment_bloc/payment_bloc.dart';
import 'package:expense_manager/core/utils/datetime_util.dart';
import 'package:expense_manager/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:expense_manager/constants.dart';
import 'package:expense_manager/core/blocs/category_bloc/category_bloc.dart';
import 'package:expense_manager/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:expense_manager/core/blocs/transaction_type_cubit/transaction_type_cubit.dart';
import 'package:expense_manager/core/entities/transaction_entity.dart';
import 'package:expense_manager/ui/add_new_payment_screen.dart';
import 'package:expense_manager/ui/add_new_category_screen.dart';
import 'package:money_formatter/money_formatter.dart';

part 'widgets/payment_bottom_sheet.dart';
part 'widgets/add_button.dart';
part 'widgets/button.dart';
part 'widgets/category_bottom_sheet.dart';
part 'widgets/money_text_field.dart';
part 'widgets/save_button.dart';

class AddNewTransactionScreen extends StatefulWidget {
  final Transaction? transaction;
  const AddNewTransactionScreen({
    Key? key,
    this.transaction,
  }) : super(key: key);

  @override
  State<AddNewTransactionScreen> createState() =>
      _AddNewTransactionScreenState();
}

class _AddNewTransactionScreenState extends State<AddNewTransactionScreen> {
  late TextEditingController controller, noteController;
  late PaymentBloc paymentBloc;
  late CategoryBloc categoryBloc;
  late TransactionBloc transactionBloc;
  late TransactionTypeCubit transactionTypeCubit;
  late DateFormat format;
  late DateTime selectedDate;
  @override
  void initState() {
    controller = TextEditingController(text: '0 \$');
    format = DateFormat('dd/MM/yyyy');
    noteController = TextEditingController(text: widget.transaction?.note);
    paymentBloc = context.read<PaymentBloc>();
    selectedDate = widget.transaction == null
        ? DateTime.now()
        : widget.transaction!.dateTime;
    categoryBloc = context.read<CategoryBloc>();
    transactionBloc = context.read<TransactionBloc>();
    transactionTypeCubit = context.read<TransactionTypeCubit>();
    if (widget.transaction != null) {
      var moneyFormatter = MoneyFormatter(
        amount: widget.transaction!.amount.toDouble(),
      ).output.withoutFractionDigits;
      controller.text = moneyFormatter + ' \$';
      categoryBloc.add(
          CategorySelected(category: widget.transaction!.category.target!));
      paymentBloc
          .add(PaymentSelected(payment: widget.transaction!.payment.target!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Expense",
          style: TextStyleUtils.medium(25),
        ),
        centerTitle: true,
        leadingWidth: 80.w,
        backgroundColor: Colors.blueGrey.shade50,
      ),
      backgroundColor: Colors.blueGrey.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2026),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Text(
                    'Date: ${format.format(selectedDate)}',
                    style: TextStyleUtils.medium(22),
                  ),
                ),
                Center(
                  child: IntrinsicWidth(
                    child: _MoneyTextField(
                      controller: controller,
                      key: const Key('moneyTextField'),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: noteController,
                    key: const Key('noteTextField'),
                    style: TextStyleUtils.regular(22),
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: '${KeyWork.enterNote.tr}',
                      hintStyle: TextStyleUtils.regular(22),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 500,
                              child: const _PaymentBottomSheet(),
                            ),
                          );
                        });
                  },
                  child: BlocBuilder<PaymentBloc, PaymentState>(
                    builder: (context, state) {
                      if (state is PaymentInitial) {
                        return const CircularProgressIndicator();
                      }
                      if (state is PaymentLoaded) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Payment method:  ",
                              style: TextStyleUtils.bold(22),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text('${state.paymentSelected.emoji} ',
                                style: TextStyleUtils.regular(28)),
                            Text(
                              state.paymentSelected.name.tr,
                              style: TextStyleUtils.medium(20),
                            ),
                          ],
                        );
                      }
                      return const Text('Something went wrong!');
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.all(10),
                            content: SizedBox(
                              width: 700,
                              child: const CategoriesBottomSheet(),
                            ),
                          );
                        });
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Category:  ",
                                style: TextStyleUtils.bold(20),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text('${state.categorySelected.emoji} ',
                                  style: TextStyleUtils.regular(28)),
                              Text(
                                state.categorySelected.name.tr,
                                style: TextStyleUtils.medium(20),
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
                SizedBox(width: 10.w),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: _SaveButton(
                  onPressed: () {
                    transactionBloc.add(
                      TransactionAdded(
                        transaction: widget.transaction == null
                            ? Transaction(
                                amount: int.parse(controller.text
                                    .replaceAll(',', '')
                                    .replaceAll('\$', '')),
                                dateTime: selectedDate.setCurrentTime(),
                                note: noteController.text,
                                type:
                                    transactionTypeCubit.state.transactionType,
                              )
                            : widget.transaction!.copyWith(
                                amount: int.parse(controller.text
                                    .replaceAll(',', '')
                                    .replaceAll('\$', '')),
                                dateTime: selectedDate.setCurrentTime(),
                                note: noteController.text,
                                type:
                                    transactionTypeCubit.state.transactionType,
                              ),
                        payment: (paymentBloc.state as PaymentLoaded)
                            .paymentSelected,
                        category: (categoryBloc.state as CategoryLoaded)
                            .categorySelected,
                      ),
                    );
                    context.read<AnalysisBloc>().add(const AnalysisStarted());
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
