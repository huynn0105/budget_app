import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/payment_bloc/payment_bloc.dart';
import 'package:budget_app/core/entities/payment_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/add_new_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class PaymentSettingScreen extends StatelessWidget {
  const PaymentSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyWork.payment.tr),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          margin: EdgeInsets.all(16.r),
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              if (state is PaymentLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      index != state.payments.length
                          ? _PaymentItem(
                              payment: state.payments[index],
                            )
                          : AddItem(
                              onTap: () {
                                Get.to(() => AddNewPaymentScreen());
                              },
                              name: KeyWork.newPayment.tr,
                            ),
                  itemCount: state.payments.length + 1,
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

class _PaymentItem extends StatelessWidget {
  const _PaymentItem({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => AddNewPaymentScreen(
              argument: AddNewPaymentArgument(payment: payment),
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
                    .read<PaymentBloc>()
                    .add(PaymentDeleted(payment: payment));
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
                payment.emoji,
                style: TextStyleUtils.regular(18),
              ),
              SizedBox(width: 10.w),
              Text(payment.name.tr, style: TextStyleUtils.regular(14))
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
