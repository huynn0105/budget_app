import 'package:expense_manager/core/blocs/analysis_bloc/analysis_bloc.dart';
import 'package:expense_manager/core/blocs/budget_bloc/budget_bloc.dart';
import 'package:expense_manager/core/blocs/category_bloc/category_bloc.dart';
import 'package:expense_manager/core/blocs/home_cubit/home_cubit.dart';
import 'package:expense_manager/core/blocs/payment_bloc/payment_bloc.dart';
import 'package:expense_manager/core/blocs/setting_bloc/setting_bloc.dart';
import 'package:expense_manager/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:expense_manager/core/blocs/transaction_type_cubit/transaction_type_cubit.dart';
import 'package:expense_manager/global/app_themes.dart';
import 'package:expense_manager/translation/app_translation.dart';
import 'package:expense_manager/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: state.themeMode,
                darkTheme: darkTheme,
                title: 'Expense'.toUpperCase(),
                theme: lightTheme,
                home: child,
                translations: AppTranslation(),
                locale: AppTranslation.getDefaultLocale(),
                color: Colors.pinkAccent,
              );
            },
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
    BlocProvider(create: (_) => PaymentBloc()..add(const PaymentStarted())),
    BlocProvider(create: (_) => CategoryBloc()..add(const CategoryStarted())),
    BlocProvider(create: (_) => TransactionTypeCubit()),
    BlocProvider(create: (_) => BottomNavBarCubit()),
    BlocProvider(create: (_) => AnalysisBloc()),
    BlocProvider(create: (_) => SettingBloc()),
    BlocProvider(create: (_) => BudgetBloc()..add(const BudgetStarted())),
  ];
}
