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
          'SPENT',
          style: TextStyleUtils.bold(26),
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
                      style: TextStyleUtils.medium(50).copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: 'đ',
                      style: TextStyleUtils.regular(30).copyWith(
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
