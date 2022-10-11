import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:budget_app/core/ui_model/category_ui_model.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/ui/category_history_screen/category_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

const double heightChart = 140.0;

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    context.read<AnalysisBloc>().add(const AnalysisStarted());
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMM dd');
    final numberFormat = NumberFormat('#,###');
    final monthFormat = DateFormat('dd/MM');
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AnalysisBloc, AnalysisState>(
            builder: (context, state) {
              if (state is AnalysisInitial) {
                return const CircularProgressIndicator();
              }
              if (state is AnalysisLoaded) {
                final between =
                    '${state.transactionOfWeek.date.isToday() ? 'this ' : ''}${state.viewType.name} ${format.format(state.transactionOfWeek.date.startOfWeek())} - ${format.format(state.transactionOfWeek.date.endOfWeek())}';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.viewType == ViewType.week ? numberFormat.format(state.totalOfWeek) : numberFormat.format(state.totalOfMonth)}đ',
                      style: TextStyleUtils.medium(30),
                    ),
                    Row(
                      children: [
                        Text(
                          'Total spent ${state.viewType == ViewType.week ? between : ''}',
                          style: TextStyleUtils.regular(12)
                              .copyWith(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 30.h,
                          child: !state.transactionOfWeek.date.isToday()
                              ? TextButton(
                                  onPressed: () {
                                    context.read<AnalysisBloc>().add(
                                        AnalysisChangeDate(
                                            date: DateTime.now(),
                                            viewType: ViewType.week));
                                  },
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      minimumSize: MaterialStateProperty.all(
                                        const Size(20, 10),
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyleUtils.medium(12)
                                              .copyWith(color: Colors.blue))),
                                  child: const Text(
                                    'Today',
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const Text('Something went wrong!');
            },
          ),
          SizedBox(
            height: heightChart + 60,
            child: BlocBuilder<AnalysisBloc, AnalysisState>(
              builder: (context, state) {
                if (state is AnalysisLoaded) {
                  final month = DateTime.now().month - 5;
                  if (state.viewType == ViewType.year && month > 0) {
                    Future.delayed(Duration.zero, () {
                      scrollController.animateTo(month * (50),
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    });
                  }
                  switch (state.viewType) {
                    case ViewType.week:
                      return Dismissible(
                        resizeDuration: null,
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            final date = state.transactionOfWeek.date.nextWeek;
                            context.read<AnalysisBloc>().add(AnalysisChangeDate(
                                date: date, viewType: ViewType.week));
                          } else {
                            final date = state.transactionOfWeek.date.prevWeek;
                            context.read<AnalysisBloc>().add(AnalysisChangeDate(
                                date: date, viewType: ViewType.week));
                          }
                        },
                        key: ValueKey(state.transactionOfWeek.date),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(listWeek.length, (index) {
                            return _ChartItem(
                              max: state.getTotalOfDay(index + 1).toDouble(),
                              value: state.maxOfTransactions != 0
                                  ? (state.getTotalOfDay(index + 1).toDouble() /
                                          state.maxOfTransactions) *
                                      heightChart
                                  : 0,
                              title: listWeek[index],
                            );
                          }),
                        ),
                      );
                    case ViewType.month:
                      final listMonth =
                          state.transactionOfMonth.date.getWeeksOfMonth();
                      return Dismissible(
                        resizeDuration: null,
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            final date =
                                state.transactionOfMonth.date.nextMonth;
                            context.read<AnalysisBloc>().add(AnalysisChangeDate(
                                date: date, viewType: ViewType.month));
                          } else {
                            final date =
                                state.transactionOfMonth.date.prevMonth;
                            context.read<AnalysisBloc>().add(AnalysisChangeDate(
                                date: date, viewType: ViewType.month));
                          }
                        },
                        key: ValueKey(state.transactionOfMonth.date),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(listMonth.length, (index) {
                            return _ChartItem(
                              max: state.getTotalOfDay(index).toDouble(),
                              value: state.maxOfTransactions != 0
                                  ? (state.getTotalOfDay(index).toDouble() /
                                          state.maxOfTransactions) *
                                      heightChart
                                  : 0,
                              title:
                                  '${monthFormat.format(listMonth[index].start)}\n${monthFormat.format(listMonth[index].end)}',
                            );
                          }),
                        ),
                      );
                    case ViewType.year:
                      return ListView.separated(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => _ChartItem(
                          max: state.getTotalOfDay(index + 1).toDouble(),
                          value: state.maxOfTransactions != 0
                              ? (state.getTotalOfDay(index + 1).toDouble() /
                                      state.maxOfTransactions) *
                                  heightChart
                              : 0,
                          title: listYear[index],
                        ),
                        itemCount: listYear.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 25),
                      );
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(height: 15.h),
          _ViewTypeWidget(
            onChanged: (value) {
              context
                  .read<AnalysisBloc>()
                  .add(AnalysisSeleteViewType(viewType: value));
            },
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: BlocBuilder<AnalysisBloc, AnalysisState>(
              builder: (context, state) {
                if (state is AnalysisLoaded) {
                  return state.transactionOfCategory.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (_, __) => Divider(
                              height: 15.h, color: Colors.grey.shade200),
                          itemCount: state.transactionOfCategory.length,
                          itemBuilder: (context, index) => _CategoryItem(
                            categoryUI: state.transactionOfCategory[index],
                          ),
                        )
                      : Center(
                          child: Text(
                            'No transaction',
                            style: TextStyleUtils.regular(12)
                                .copyWith(color: Colors.black54),
                          ),
                        );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key? key,
    required this.categoryUI,
  }) : super(key: key);

  final CategoryUIModel categoryUI;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                CategoryHistoryScreen(categoryUIModel: categoryUI)));
      },
      child: Row(
        children: [
          Text(
            categoryUI.category.emoji,
            style: TextStyleUtils.regular(26),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              categoryUI.category.name,
              style: TextStyleUtils.regular(15),
            ),
          ),
          Text(
            '${format.format(categoryUI.total)}đ',
            style: TextStyleUtils.regular(15),
          ),
        ],
      ),
    );
  }
}

class _ChartItem extends StatelessWidget {
  const _ChartItem({
    Key? key,
    required this.value,
    required this.title,
    required this.max,
  }) : super(key: key);
  final double value;
  final String title;
  final double max;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
          child: max != 0
              ? Text(
                  MoneyFormatter(amount: max).output.compactNonSymbol,
                  style: TextStyleUtils.regular(10)
                      .copyWith(color: Colors.black54),
                )
              : null,
        ),
        Container(
          height: heightChart,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: value,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.black87),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyleUtils.regular(11).copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

class _ViewTypeWidget extends StatefulWidget {
  const _ViewTypeWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final ValueChanged<ViewType> onChanged;

  @override
  State<_ViewTypeWidget> createState() => _ViewTypeWidgetState();
}

class _ViewTypeWidgetState extends State<_ViewTypeWidget> {
  ValueNotifier<int> selected = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) => ValueListenableBuilder(
            valueListenable: selected,
            builder: (context, int value, _) {
              final isActive = value == index;
              return ElevatedButton(
                onPressed: () {
                  selected.value = index;
                  widget.onChanged(ViewType.values[index]);
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        isActive ? Colors.black87 : Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h)),
                    minimumSize: MaterialStateProperty.all(
                      const Size(18, 28),
                    ),
                    side: !isActive
                        ? MaterialStateProperty.all(
                            BorderSide(color: Colors.grey.shade300))
                        : null),
                child: Text(
                  ViewType.values[index].name[0].toUpperCase() +
                      ViewType.values[index].name.substring(1),
                  style: TextStyleUtils.regular(12).copyWith(
                      color: isActive ? Colors.white : Colors.black87),
                ),
              );
            }),
        itemCount: ViewType.values.length,
      ),
    );
  }
}
