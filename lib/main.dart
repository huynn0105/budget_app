import 'package:budget_app/core/blocs/account_bloc/account_bloc.dart';
import 'package:budget_app/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/blocs/home_cubit/home_cubit.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/blocs/transaction_type_cubit/transaction_type_cubit.dart';
import 'package:budget_app/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'global/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: listBlocProvider,
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

List<BlocProviderSingleChildWidget> get listBlocProvider {
  return [
    BlocProvider(create: (_) => TransactionBloc()),
    BlocProvider(create: (_) => AccountBloc()..add(const AccountStarted())),
    BlocProvider(create: (_) => CategoryBloc()..add(const CategoryStarted())),
    BlocProvider(create: (_) => TransactionTypeCubit()),
    BlocProvider(create: (_) => BottomNavBarCubit()),
    BlocProvider(create: (_) => AnalysisBloc()),
  ];
}
