import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/account_bloc/account_bloc.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EraseDataSettingScreen extends StatelessWidget {
  const EraseDataSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyWork.eraseData.tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            KeyWork.eraseAllTransactions.tr,
                            style: TextStyleUtils.medium(16),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                KeyWork.cancel.tr,
                                style: TextStyleUtils.medium(14)
                                    .copyWith(color: Colors.blue),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: Text(
                                KeyWork.eraseData.tr,
                                style: TextStyleUtils.medium(14)
                                    .copyWith(color: Colors.red),
                              ),
                              onPressed: () {
                                context
                                    .read<TransactionBloc>()
                                    .add(TransactionClear());
                                Get.back();
                              },
                            ),
                          ],
                        ));
              },
              child: Text(
                KeyWork.eraseAllTransactions.tr,
                style: TextStyleUtils.regular(14)
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  elevation: 0.5,
                  alignment: AlignmentDirectional.centerStart,
                  minimumSize: Size(double.infinity, 50.h)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                KeyWork.messageEraseAll.tr,
                style: TextStyleUtils.light(11).copyWith(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            KeyWork.restoreToDefault.tr,
                            style: TextStyleUtils.medium(16),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                KeyWork.cancel.tr,
                                style: TextStyleUtils.medium(14)
                                    .copyWith(color: Colors.blue),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: Text(
                                KeyWork.eraseData.tr,
                                style: TextStyleUtils.medium(14)
                                    .copyWith(color: Colors.red),
                              ),
                              onPressed: () {
                                context
                                    .read<TransactionBloc>()
                                    .add(TransactionClear());
                                context
                                    .read<CategoryBloc>()
                                    .add(CategoryClear());
                                context.read<AccountBloc>().add(AccountClear());
                                Get.back();
                              },
                            ),
                          ],
                        ));
              },
              child: Text(
                KeyWork.restoreApp.tr,
                style: TextStyleUtils.regular(14)
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  elevation: 0.5,
                  alignment: AlignmentDirectional.centerStart,
                  minimumSize: Size(double.infinity, 50.h)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                KeyWork.messageRestoreApp.tr,
                style: TextStyleUtils.light(11).copyWith(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
