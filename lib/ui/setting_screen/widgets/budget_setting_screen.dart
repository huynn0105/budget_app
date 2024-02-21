import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/budget_bloc/budget_bloc.dart';
import 'package:budget_app/core/entities/budget_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/add_new_budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'category_setting_screen.dart';

class BudgetSettingScreen extends StatelessWidget {
  const BudgetSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyWork.category.tr),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          margin: EdgeInsets.all(16.r),
          child: BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => index != state.budgets.length
                      ? _BudgetItem(
                          budget: state.budgets[index],
                        )
                      : AddItem(
                          onTap: () {
                            Get.to(() => AddNewBudgetScreen());
                          },
                          name: KeyWork.newCategory.tr,
                        ),
                  itemCount: state.budgets.length + 1,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.h,
                    color: Colors.grey.shade300,
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class _BudgetItem extends StatelessWidget {
  const _BudgetItem({
    Key? key,
    required this.budget,
  }) : super(key: key);

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => AddNewBudgetScreen(
              argument: AddNewBudgetArgument(budget: budget),
            ));
      },
      child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              Text(
                budget.image,
                style: TextStyleUtils.regular(18),
              ),
              SizedBox(width: 10.w),
              Text(budget.name.tr, style: TextStyleUtils.regular(14)),
            ],
          ),
        ),
    
    );
  }
}
