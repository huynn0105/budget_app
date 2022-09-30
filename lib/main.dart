import 'package:budget_app/core/blocs/account_bloc/account_bloc.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/blocs/transaction_type_cubit/transaction_type_cubit.dart';
import 'package:budget_app/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'global/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => TransactionBloc()),
            BlocProvider(create: (_) => AccountBloc()),
            BlocProvider(create: (_) => CategoryBloc()),
            BlocProvider(create: (_) => TransactionTypeCubit()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo'.toUpperCase(),
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: child,
          ),
        );
      },
      child: const HomeScreen(),
    );
  }
}
