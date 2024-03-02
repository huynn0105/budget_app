import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

import 'package:pie_chart/pie_chart.dart' as pie;

import '../../core/blocs/setting_bloc/setting_bloc.dart';
import '../../core/utils/enum_helper.dart';
import 'package:intl/date_symbol_data_local.dart';

part 'widgets/custom_legend.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    context.read<AnalysisBloc>().add(const AnalysisStarted());
    super.initState();
  }

  final colorList = const [
    Color(0xFF0A7AFF),
    Color(0xFFFF7824),
    Color(0xFFFFDE24),
    Color(0xFFD7D6D6),
    Color(0xFF00D7FF),
    Color(0xFF9D8FE9),
    Color(0xFFFF5168),
    Color(0xFF1EB705),
  ];

  Color getColor(List<Color> colorList, int index) {
    if (index > (colorList.length - 1)) {
      final newIndex = index % (colorList.length - 1);
      return colorList.elementAt(newIndex);
    }
    return colorList.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    final formater =
        context.read<SettingBloc>().state.language == Language.english
            ? DateFormat('MMM dd', 'en')
            : DateFormat('dd MMM', 'vi');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          KeyWork.chart.tr,
          style: TextStyleUtils.medium(18),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.w),
          //   child: BlocBuilder<AnalysisBloc, AnalysisState>(
          //       builder: (context, state) {
          //     if (state is AnalysisLoaded) {
          //       final between =
          //           '${formater.format(state.transactionOfWeek.date.startOfWeek())} - ${formater.format(state.transactionOfWeek.date.endOfWeek())}';
          //       return Text(
          //         '${KeyWork.week.tr} $between'.toUpperCase(),
          //         style: TextStyleUtils.medium(18),
          //       );
          //     }
          //     return const CircularProgressIndicator();
          //   }),
          // ),
          // SizedBox(height: 10.h),
          // BlocBuilder<AnalysisBloc, AnalysisState>(
          //   builder: (context, state) {
          //     if (state is AnalysisLoaded) {
          //       Map<Category, List<Transaction>> transactionOfCategory = state
          //           .transactionOfWeek.transactions
          //           .groupListsBy<Category>((x) => x.category.target!);

          //       return Dismissible(
          //           resizeDuration: null,
          //           onDismissed: (DismissDirection direction) {
          //             if (direction == DismissDirection.endToStart) {
          //               final DateTime date = state.transactionOfWeek.date
          //                   .add(const Duration(days: 7));
          //               context.read<AnalysisBloc>().add(AnalysisChangeDate(
          //                   date: date, viewType: ViewType.week));
          //             } else {
          //               final DateTime date = state.transactionOfWeek.date
          //                   .subtract(const Duration(days: 7));
          //               context.read<AnalysisBloc>().add(AnalysisChangeDate(
          //                   date: date, viewType: ViewType.week));
          //             }
          //           },
          //           key: ValueKey(state.transactionOfWeek.date),
          //           child: Row(
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
          //                 child: pie.PieChart(
          //                   dataMap: transactionOfCategory.entries.isNotEmpty
          //                       ? {
          //                           for (var item
          //                               in transactionOfCategory.entries)
          //                             item.key.name: item.value
          //                                 .fold(0, (prev, e) => prev + e.amount)
          //                                 .toDouble()
          //                         }
          //                       : {'No data': 0},
          //                   animationDuration: const Duration(
          //                     milliseconds: 800,
          //                   ),
          //                   chartLegendSpacing: 32.r,
          //                   chartRadius: 1.sw / 2.5,
          //                   colorList: colorList,
          //                   chartType: pie.ChartType.disc,
          //                   ringStrokeWidth: 1,
          //                   legendOptions: const pie.LegendOptions(
          //                     showLegends: false,
          //                   ),
          //                   chartValuesOptions: const pie.ChartValuesOptions(
          //                     showChartValues: false,
          //                   ),
          //                 ),
          //               ),
          //               Expanded(
          //                 child: SizedBox(
          //                   height: 1.sw / 2.4,
          //                   child: transactionOfCategory.entries.isNotEmpty
          //                       ? ListView.builder(
          //                           itemCount:
          //                               transactionOfCategory.entries.length,
          //                           itemBuilder: (context, index) {
          //                             double totalAmount = transactionOfCategory
          //                                 .entries
          //                                 .toList()[index]
          //                                 .value
          //                                 .fold(
          //                                     0,
          //                                     (prevValue, e) =>
          //                                         prevValue +
          //                                         (e.type ==
          //                                                 TransactionType.income
          //                                             ? e.amount
          //                                             : (-e.amount)));
          //                             var totalAmountFormat = MoneyFormatter(
          //                               amount: totalAmount.abs(),
          //                             ).output.compactNonSymbol;
          //                             if (totalAmount < 0) {
          //                               totalAmountFormat =
          //                                   '-' + totalAmountFormat;
          //                             }
          //                             return _CustomLegend(
          //                               color: getColor(colorList, index),
          //                               title: totalAmountFormat +
          //                                   ' - ' +
          //                                   transactionOfCategory.entries
          //                                       .toList()[index]
          //                                       .key
          //                                       .name
          //                                       .tr,
          //                             );
          //                           })
          //                       : Center(child: Text(KeyWork.noTrnsaction.tr)),
          //                 ),
          //               ),
          //             ],
          //           ));
          //     }
          //     return const CircularProgressIndicator();
          //   },
          // ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<AnalysisBloc, AnalysisState>(
                builder: (context, state) {
              if (state is AnalysisLoaded) {
                return Text(
                  '${KeyWork.month.tr} ${state.transactionOfMonth.date.month}'
                      .toUpperCase(),
                  style: TextStyleUtils.medium(18),
                );
              }
              return const CircularProgressIndicator();
            }),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<AnalysisBloc, AnalysisState>(
            builder: (context, state) {
              if (state is AnalysisLoaded) {
                Map<Category, List<Transaction>> transactionOfCategory = state
                    .transactionOfMonth.transactions
                    .groupListsBy<Category>((x) => x.category);

                return Dismissible(
                    resizeDuration: null,
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.endToStart) {
                        final date = DateTime(
                            state.transactionOfMonth.date.year,
                            state.transactionOfMonth.date.month + 1,
                            state.transactionOfMonth.date.day);
                        context.read<AnalysisBloc>().add(AnalysisChangeDate(
                            date: date, viewType: ViewType.month));
                      } else {
                        final date = DateTime(
                            state.transactionOfMonth.date.year,
                            state.transactionOfMonth.date.month - 1,
                            state.transactionOfMonth.date.day);
                        context.read<AnalysisBloc>().add(AnalysisChangeDate(
                            date: date, viewType: ViewType.month));
                      }
                    },
                    key: ValueKey(state.transactionOfMonth.date),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: pie.PieChart(
                            dataMap: transactionOfCategory.entries.isNotEmpty
                                ? {
                                    for (var item
                                        in transactionOfCategory.entries)
                                      item.key.name: item.value
                                          .fold(0, (prev, e) => prev + e.amount)
                                          .toDouble()
                                  }
                                : {KeyWork.noTrnsaction.tr: 0},
                            animationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            chartLegendSpacing: 32.r,
                            chartRadius: 1.sw / 2.5,
                            colorList: colorList,
                            chartType: pie.ChartType.disc,
                            ringStrokeWidth: 1,
                            legendOptions: const pie.LegendOptions(
                              showLegends: false,
                            ),
                            chartValuesOptions: const pie.ChartValuesOptions(
                              showChartValues: false,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 1.sw / 2.4,
                            child: transactionOfCategory.entries.isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        transactionOfCategory.entries.length,
                                    itemBuilder: (context, index) {
                                      double totalAmount = transactionOfCategory
                                          .entries
                                          .toList()[index]
                                          .value
                                          .fold(
                                              0,
                                              (prevValue, e) =>
                                                  prevValue +
                                                  (e.type ==
                                                          TransactionType.income
                                                      ? e.amount
                                                      : (-e.amount)));
                                      var totalAmountFormat = MoneyFormatter(
                                        amount: totalAmount.abs(),
                                      ).output.compactNonSymbol;
                                      if (totalAmount < 0) {
                                        totalAmountFormat =
                                            '-' + totalAmountFormat;
                                      }
                                      return _CustomLegend(
                                        color: getColor(colorList, index),
                                        title: totalAmountFormat +
                                            ' - ' +
                                            transactionOfCategory.entries
                                                .toList()[index]
                                                .key
                                                .name
                                                .tr,
                                      );
                                    })
                                : Center(child: Text(KeyWork.noTrnsaction.tr)),
                          ),
                        ),
                      ],
                    ));
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
