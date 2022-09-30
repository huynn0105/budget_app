part of '../home_screen.dart';

class _SpentThisMonth extends StatelessWidget {
  const _SpentThisMonth({
    Key? key,
    required this.format,
  }) : super(key: key);

  final NumberFormat format;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Spent this month',
          style: TextStyleUtils.regular(14).copyWith(color: Colors.black54),
        ),
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
                      text: format.format(state.total),
                      style: TextStyleUtils.regular(38).copyWith(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'đ',
                      style: TextStyleUtils.regular(20)
                          .copyWith(color: Colors.black54),
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
