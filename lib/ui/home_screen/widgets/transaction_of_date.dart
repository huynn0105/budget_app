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
    initializeDateFormatting();
    final formater =
        context.read<SettingBloc>().state.language == Language.english
            ? DateFormat('MMM dd', 'en')
            : DateFormat('dd MMM', 'vi');
    final total = transactions.fold(
        0,
        (prevValue, x) =>
            prevValue +
            (x.type == TransactionType.expense ? -x.amount : x.amount));
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
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
                      date.isToday() ? KeyWork.today.tr : formater.format(date),
                      style: TextStyleUtils.regular(17),
                    ),
                    Text(
                      '${format.format(total)}đ',
                      style: TextStyleUtils.regular(17),
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
                Divider(height: 2.h, color: Colors.purpleAccent),
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
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    KeyWork.eraseData.tr,
                    style: TextStyleUtils.medium(16),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        KeyWork.cancel.tr,
                        style: TextStyleUtils.medium(14)
                            .copyWith(color: Colors.deepPurpleAccent),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: Text(
                        KeyWork.eraseData.tr,
                        style: TextStyleUtils.medium(14)
                            .copyWith(color: Colors.deepPurple),
                      ),
                      onPressed: () {
                        context.read<TransactionBloc>().add(
                              TransactionDeleted(transaction: transaction),
                            );
                        Get.back();
                      },
                    ),
                  ],
                ));
      },
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddNewTransactionScreen(
              transaction: transaction,
            );
          },
        );
      },
      child: ColoredBox(
        color: transaction.type == TransactionType.income
            ? Colors.green.withOpacity(0.06)
            : Colors.purple.withOpacity(0.06),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.r, horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    transaction.category.target!.emoji,
                    style: TextStyleUtils.regular(30),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      transaction.category.target!.name.tr,
                      style: TextStyleUtils.regular(16),
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
                        .copyWith(color: Colors.deepPurpleAccent),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
