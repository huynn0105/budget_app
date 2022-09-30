part of '../home_screen.dart';

class _TransactionOfDate extends StatelessWidget {
  const _TransactionOfDate({
    Key? key,
    required this.date,
    required this.transactions,
  }) : super(key: key);

  final DateTime date;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');
    final total = transactions.fold(0, (prevValue, x) => prevValue + x.amount);
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date.isToday() ? 'Today' : DateFormat('dd/MMM').format(date),
                  style: TextStyleUtils.regular(15)
                      .copyWith(color: Colors.black45),
                ),
                Text(
                  '${format.format(total)}đ',
                  style: TextStyleUtils.regular(15)
                      .copyWith(color: Colors.black45),
                ),
              ],
            ),
            Divider(height: 15.h, color: Colors.grey.shade400),
          ],
        ),
        Expanded(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionInitial) {
                return const CircularProgressIndicator();
              }
              if (state is TransactionLoaded) {
                if (state.transactions.isNotEmpty) {
                  return ListView.separated(
                    separatorBuilder: (_, __) =>
                        Divider(height: 14.h, color: Colors.grey.shade200),
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    itemBuilder: (context, index) {
                      final Transaction transaction = state.transactions[index];
                      return Row(
                        children: [
                          Text(
                            transaction.category.target!.emoji,
                            style: TextStyleUtils.regular(28),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  transaction.category.target!.name,
                                  style: TextStyleUtils.regular(16),
                                ),
                                SizedBox(width: 5.w),
                                transaction.title.isNotEmpty
                                    ? Text(
                                        '(${transaction.title})',
                                        style: TextStyleUtils.regular(13)
                                            .copyWith(color: Colors.black45),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                          Text(
                            '${format.format(transaction.amount)}đ',
                            style: TextStyleUtils.regular(16),
                          ),
                        ],
                      );
                    },
                    itemCount: state.transactions.length,
                  );
                }
                return const Text('Not record');
              }
              return const Text('Something went wrong!');
            },
          ),
        ),
      ],
    );
  }
}
