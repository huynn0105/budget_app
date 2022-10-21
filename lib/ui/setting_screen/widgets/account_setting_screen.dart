import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/account_bloc/account_bloc.dart';
import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/add_new_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyWork.account.tr),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          margin: EdgeInsets.all(16.r),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      index != state.accounts.length
                          ? _AccountItem(
                              account: state.accounts[index],
                            )
                          : AddItem(
                              onTap: () {
                                Get.to(() => AddNewAccountScreen());
                              },
                              name: KeyWork.newAccount.tr,
                            ),
                  itemCount: state.accounts.length + 1,
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

class _AccountItem extends StatelessWidget {
  const _AccountItem({
    Key? key,
    required this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => AddNewAccountScreen(
              argument: AddNewAccountArgument(account: account),
            ));
      },
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.23,
          key: const ValueKey(1),
          children: [
            SlidableAction(
              onPressed: (context) {
                context
                    .read<AccountBloc>()
                    .add(AccountDeleted(account: account));
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              Text(
                account.emoji,
                style: TextStyleUtils.regular(18),
              ),
              SizedBox(width: 10.w),
              Text(account.name.tr, style: TextStyleUtils.regular(14))
            ],
          ),
        ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  const AddItem({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 26.r,
            ),
            SizedBox(width: 10.w),
            Text(name, style: TextStyleUtils.regular(14))
          ],
        ),
      ),
    );
  }
}
