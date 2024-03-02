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
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionInitial) {
              return const CircularProgressIndicator();
            }
            if (state is TransactionLoaded) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 45,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: format.format(state.totalThisWeek),
                          style: TextStyleUtils.extraBold(45).copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: '\$',
                          style: TextStyleUtils.extraBold(45).copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ],
    );
  }
}
