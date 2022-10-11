import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/home_cubit/home_cubit.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/ui/chart_screen/chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../add_new_transaction_screen/add_new_transaction_screen.dart';
import '../analysis_screen/analysis_screen.dart';
part 'widgets/transaction_of_date.dart';
part 'widgets/spent_this_month.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TransactionBloc>().add(const TransactionStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget homeScreen(BottomNavBar item) {
      switch (item) {
        case BottomNavBar.home:
          return const HomeWidget();
        case BottomNavBar.analysis:
          return const AnalysisScreen();
        case BottomNavBar.chart:
          return const ChartScreen();
      }
    }

    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade50,
            toolbarHeight: 20,
          ),
          resizeToAvoidBottomInset: false,
          body: homeScreen(state.navBar),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            elevation: 1,
            backgroundColor: Colors.grey.shade200,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_outlined_outlined), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart_outline_sharp), label: ''),
            ],
            currentIndex: state.navBar.index,
            onTap: (index) {
              context.read<BottomNavBarCubit>().onItemTapped(index);
            },
          ),
          floatingActionButton: FloatingActionButton.small(
            backgroundColor: Colors.black,
            key: const Key('addNewTransaction'),
            onPressed: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (context) {
                  return const AddNewTransactionScreen();
                },
              );
            },
            elevation: 0,
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: _SpentThisWeek(),
          ),
          SizedBox(height: 40.h),
          Expanded(
            flex: 4,
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionInitial) {
                  return const CircularProgressIndicator();
                }
                if (state is TransactionLoaded) {
                  return ListView(
                    children: state.transactionOfDate.entries
                        .map((e) => _TransactionOfDate(
                            date: e.key, transactions: e.value))
                        .toList(),
                  );
                }
                return const Text('Something went wrong!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
