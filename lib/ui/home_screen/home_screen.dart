import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/entities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:budget_app/core/utils/datetime_util.dart';
import '../add_new_transaction_screen/add_new_transaction_screen.dart';

part 'widgets/spent_this_month.dart';
part 'widgets/transaction_of_date.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<TransactionBloc>().add(TransactionStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat('#,###');
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: _SpentThisMonth(format: format),
            ),
            Expanded(
              flex: 5,
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
      ),
      bottomNavigationBar: ColoredBox(
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(Icons.home),
              ),
              InkWell(
                onTap: () {},
                child: const Icon(Icons.insert_chart_outlined_outlined),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black,
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
