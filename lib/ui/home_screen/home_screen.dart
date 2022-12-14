import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/budget_bloc/budget_bloc.dart';
import 'package:budget_app/core/blocs/home_cubit/home_cubit.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/add_new_budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../core/blocs/setting_bloc/setting_bloc.dart';
import '../add_new_transaction_screen/add_new_transaction_screen.dart';
import '../analysis_screen/analysis_screen.dart';
import '../setting_screen/setting_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Widget homeScreen(BottomNavBar item) {
      switch (item) {
        case BottomNavBar.home:
          return HomeWidget(
            scaffoldKey: scaffoldKey,
          );
        case BottomNavBar.analysis:
          return const AnalysisScreen();
        case BottomNavBar.settiing:
          return SettingScreen();
      }
    }

    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 20,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
          ),
          body: homeScreen(state.navBar),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 1,
            iconSize: 28,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart_outlined_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ],
            currentIndex: state.navBar.index,
            onTap: (index) {
              context.read<BottomNavBarCubit>().onItemTapped(index);
            },
          ),
          drawer: Drawer(
            child: BlocBuilder<BudgetBloc, BudgetState>(
              builder: (context, state) {
                if (state is BudgetLoaded) {
                  return ListView(
                    children: [
                      DrawerHeader(
                          child: Column(
                        children: [
                          Text(
                            state.currentBudget.image,
                            style: TextStyleUtils.bold(45),
                          ),
                          SizedBox(height: 10),
                          Text(state.currentBudget.name.tr),
                        ],
                      )),
                      ...state.budgets
                          .where((e) => e.id != state.currentBudget.id)
                          .map((e) => ListTile(
                                title: Text(e.name.tr),
                                leading: Icon(Icons.account_box),
                                onTap: () {
                                  context
                                      .read<BudgetBloc>()
                                      .add(BudgetChanged(budget: e));
                                  context
                                      .read<TransactionBloc>()
                                      .add(TransactionStarted());
                                  scaffoldKey.currentState!.openEndDrawer();
                                },
                              ))
                          .toList(),
                      ListTile(
                        title: Text(KeyWork.newBudget.tr),
                        onTap: () {
                          Get.to(() => AddNewBudgetScreen());
                        },
                        minLeadingWidth: 20,
                        minVerticalPadding: 10,
                        horizontalTitleGap: 10,
                        leading: Icon(Icons.add_box_rounded),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
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
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
                  //Scaffold.of(context).openDrawer();
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.menu),
                ),
              ),
              Spacer(),
              BlocBuilder<BudgetBloc, BudgetState>(
                builder: (context, state) {
                  if (state is BudgetLoaded) {
                    return Row(
                      children: [
                        Text(
                          state.currentBudget.name.tr,
                          style: TextStyleUtils.regular(16),
                        ),
                        Text(
                          state.currentBudget.image,
                          style: TextStyleUtils.regular(18),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
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
