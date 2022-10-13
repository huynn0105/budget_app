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
    final total = transactions.fold(
        0,
        (prevValue, x) =>
            prevValue +
            (x.type == TransactionType.expense ? -x.amount : x.amount));
    return Card(
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date.isToday()
                          ? 'Today'
                          : DateFormat('MMM dd').format(date),
                      style: TextStyleUtils.regular(17)
                          .copyWith(color: Colors.black45),
                    ),
                    Text(
                      '${format.format(total)}đ',
                      style: TextStyleUtils.regular(17)
                          .copyWith(color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Divider(height: 1.h, color: Colors.grey.shade300),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
                Divider(height: 1.h, color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              return _TransactionItem(transaction: transactions[index]);
            },
            itemCount: transactions.length,
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');
    return ColoredBox(
      color: transaction.type == TransactionType.income
          ? Colors.blue.withOpacity(0.06)
          : Colors.red.withOpacity(0.06),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.r, horizontal: 16.r),
        child: Row(
          children: [
            Text(
              transaction.category.target!.emoji,
              style: TextStyleUtils.regular(30),
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
                          style: TextStyleUtils.regular(14)
                              .copyWith(color: Colors.black45),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            Text(
              '${transaction.type == TransactionType.expense ? '-' : ''}${format.format(transaction.amount)}đ',
              style: TextStyleUtils.regular(16),
            ),
          ],
        ),
      ),
    );
  }
}
