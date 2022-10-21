import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:budget_app/core/blocs/setting_bloc/setting_bloc.dart';
import 'package:budget_app/core/ui_model/category_ui_model.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/category_history_screen/category_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';

const double heightChart = 160.0;

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
    initializeDateFormatting();
    final formater =
        context.read<SettingBloc>().state.language == Language.english
            ? DateFormat('MMM dd', 'en')
            : DateFormat('dd MMM', 'vi');
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
                String between = '';
                switch (state.viewType) {
                  case ViewType.week:
                    between =
                        "${state.transactionOfWeek.date.isToday() ? KeyWork.thisWeek.tr : ''} ${formater.format(state.transactionOfWeek.date.startOfWeek())} - ${formater.format(state.transactionOfWeek.date.endOfWeek())}";
                    break;
                  case ViewType.month:
                    final format = DateFormat(
                        'MMMM',
                        context.read<SettingBloc>().state.language ==
                                Language.english
                            ? 'en'
                            : 'vi');
                    between = format.format(state.transactionOfMonth.date);
                    break;
                  case ViewType.year:
                    between = KeyWork.year.tr +
                        ' ${state.transactionOfYear.date.year}';
                    break;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 56.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            state.viewType == ViewType.week
                                ? numberFormat.format(state.totalOfWeek)
                                : state.viewType == ViewType.month
                                    ? numberFormat.format(state.totalOfMonth)
                                    : numberFormat.format(state.totalOfYear),
                            style: TextStyleUtils.medium(40),
                          ),
                          Text(
                            'đ',
                            style: TextStyleUtils.regular(30),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${KeyWork.totalSpent.tr} $between',
                          style: TextStyleUtils.regular(16),
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
                                        const Size(30, 15),
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
                                          TextStyleUtils.medium(14)
                                              .copyWith(color: Colors.blue))),
                                  child: Text(
                                    KeyWork.today.tr,
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
          BlocBuilder<AnalysisBloc, AnalysisState>(
            builder: (context, state) {
              if (state is AnalysisLoaded) {
                return _ViewTypeWidget(
                  initValue: state.viewType.index,
                  onChanged: (value) {
                    context
                        .read<AnalysisBloc>()
                        .add(AnalysisSeleteViewType(viewType: value));
                  },
                );
              }
              return CircularProgressIndicator();
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
                            KeyWork.noTrnsaction.tr,
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
            style: TextStyleUtils.regular(28),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              categoryUI.category.name,
              style: TextStyleUtils.regular(16),
            ),
          ),
          Text(
            '${format.format(categoryUI.total)}đ',
            style: TextStyleUtils.regular(16),
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
                  style: TextStyleUtils.regular(14),
                )
              : null,
        ),
        Container(
          height: heightChart,
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: value,
                width: 26.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyleUtils.regular(13),
        ),
      ],
    );
  }
}

class _ViewTypeWidget extends StatefulWidget {
  const _ViewTypeWidget({
    Key? key,
    required this.onChanged,
    required this.initValue,
  }) : super(key: key);
  final ValueChanged<ViewType> onChanged;
  final int initValue;

  @override
  State<_ViewTypeWidget> createState() => _ViewTypeWidgetState();
}

class _ViewTypeWidgetState extends State<_ViewTypeWidget> {
  late ValueNotifier<int> selected;
  @override
  void initState() {
    selected = ValueNotifier(widget.initValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
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
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h)),
                    minimumSize: MaterialStateProperty.all(
                      const Size(70, 28),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      const Size(80, 28),
                    ),
                    side: !isActive
                        ? MaterialStateProperty.all(
                            BorderSide(color: Colors.grey.shade300))
                        : null),
                child: Text(
                  ViewType.values[index] == ViewType.week
                      ? KeyWork.week.tr.toUpperCase()
                      : ViewType.values[index] == ViewType.month
                          ? KeyWork.month.tr.toUpperCase()
                          : KeyWork.year.tr.toUpperCase(),
                  style: TextStyleUtils.regular(14).copyWith(
                      color: isActive ? Colors.white : Colors.black87),
                ),
              );
            }),
        itemCount: ViewType.values.length,
      ),
    );
  }
}
