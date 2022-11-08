part of '../add_new_transaction_screen.dart';

class _PaymentBottomSheet extends StatelessWidget {
  const _PaymentBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              KeyWork.payment.tr,
              style: TextStyleUtils.medium(18),
            ),
            SizedBox(height: 10.h),
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentInitial) {
                  return const CircularProgressIndicator();
                }
                if (state is PaymentLoaded) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.payments.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) => index !=
                            state.payments.length
                        ? _Button(
                            emoji: state.payments[index].emoji,
                            name: state.payments[index].name.tr,
                            onLongPress: () {
                              context.read<PaymentBloc>().add(PaymentDeleted(
                                  payment: state.payments[index]));
                            },
                            onTap: () {
                              context.read<PaymentBloc>().add(PaymentSelected(
                                  payment: state.payments[index]));
                            },
                          )
                        : _AddButton(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AddNewPaymentScreen()));
                            },
                          ),
                  );
                }
                return const Text('Something went wrong!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
