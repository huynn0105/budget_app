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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history_rounded,
                          size: 30,
                          color: Colors.pink,
                        ),
                        SizedBox(width: 5),
                        Text(
                          date.isToday()
                              ? KeyWork.today.tr
                              : formater.format(date),
                          style: TextStyleUtils.medium(20),
                        ),
                        Spacer(),
                        Text(
                          '${format.format(total)} \$',
                          style: TextStyleUtils.medium(20),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1.h, color: Colors.grey.shade300),
                ],
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) =>
              Divider(height: 2.h, color: Colors.white),
          itemBuilder: (context, index) {
            return _TransactionItem(
              transaction: transactions[index],
              isColor: index % 2 != 0,
            );
          },
          itemCount: transactions.length,
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    Key? key,
    required this.transaction,
    this.isColor = true,
  }) : super(key: key);
  final Transaction transaction;
  final bool isColor;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');
    final colos = [
      Color.fromARGB(255, 164, 205, 225),
      Color.fromARGB(224, 213, 172, 199)
    ];
    final colors = [
      Color.fromARGB(224, 213, 172, 199),
      Color.fromARGB(255, 164, 205, 225),
    ];
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
                            .copyWith(color: Colors.pinkAccent),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: Text(
                        KeyWork.eraseData.tr,
                        style: TextStyleUtils.medium(14)
                            .copyWith(color: Colors.pinkAccent),
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
        Get.to(() => AddNewTransactionScreen(
              transaction: transaction,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: isColor ? colos : colors),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0.r, horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    transaction.category.target!.emoji,
                    style: TextStyleUtils.regular(22),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      transaction.category.target!.name.tr,
                      style: TextStyleUtils.medium(18).copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    '${transaction.type == TransactionType.expense ? '-' : ''}${format.format(transaction.amount)} \$',
                    style: TextStyleUtils.medium(18).copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (transaction.note.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '${transaction.note}',
                    style: TextStyleUtils.regular(14)
                        .copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
