part of '../home_screen.dart';

class _SpentThisWeek extends StatelessWidget {
  const _SpentThisWeek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          KeyWork.spentThisWeek.tr,
          style: TextStyleUtils.regular(16),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionInitial) {
              return const CircularProgressIndicator();
            }
            if (state is TransactionLoaded) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: format.format(state.totalThisWeek),
                      style: TextStyleUtils.regular(45).copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: 'đ',
                      style: TextStyleUtils.regular(25).copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ],
    );
  }
}
