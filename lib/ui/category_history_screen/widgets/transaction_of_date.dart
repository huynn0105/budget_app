part of '../category_history_screen.dart';

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
    initializeDateFormatting();
    final formater =
        context.read<SettingBloc>().state.language == Language.english
            ? DateFormat('EEE, dd/MM/yyyy', 'en')
            : DateFormat('EEE, dd/MM/yyyy', 'vi');
    final total = transactions.fold(
        0,
        (prevValue, x) =>
            prevValue +
            (x.type == TransactionType.expense ? -x.amount : x.amount));
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date.isToday() ? KeyWork.today.tr : formater.format(date),
                    style: TextStyleUtils.regular(18),
                  ),
                  Text(
                    '${format.format(total)}đ',
                    style: TextStyleUtils.regular(16),
                  ),
                ],
              ),
              Divider(height: 15.h, color: Colors.grey.shade300),
            ],
          ),
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
        SizedBox(height: 30.h),
      ],
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
          ? Colors.blue.withOpacity(0.08)
          : Colors.red.withOpacity(0.08),
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  DateFormat('HH:mm').format(transaction.dateTime),
                  style: TextStyleUtils.regular(12),
                ),
                SizedBox(width: 5.w),
                Text(
                  transaction.category.target!.emoji,
                  style: TextStyleUtils.regular(30),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    transaction.category.target!.name.tr,
                    style: TextStyleUtils.regular(18),
                  ),
                ),
                Text(
                  '${transaction.type == TransactionType.expense ? '-' : ''}${format.format(transaction.amount)}đ',
                  style: TextStyleUtils.regular(16),
                ),
              ],
            ),
            if (transaction.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  '${transaction.note}',
                  style: TextStyleUtils.regular(14)
                      .copyWith(color: Colors.black45),
                ),
              )
          ],
        ),
      ),
    );
  }
}
