import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/setting_bloc/setting_bloc.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DarkModeSettingScreen extends StatefulWidget {
  const DarkModeSettingScreen({super.key});

  @override
  State<DarkModeSettingScreen> createState() => _DarkModeSettingScreenState();
}

class _DarkModeSettingScreenState extends State<DarkModeSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          KeyWork.darkMode.tr,
        ),
        elevation: 0,
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        elevation: 0.8,
        margin: EdgeInsets.all(16.r),
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectionItem(
                  active: state.themeMode == ThemeMode.system,
                  title: KeyWork.system.tr,
                  onTap: () {
                    context.read<SettingBloc>().add(
                        SettingThemeModeChanged(themeMode: ThemeMode.system));
                    Get.back();
                  },
                ),
                Divider(height: 1.h, color: Colors.grey.shade300),
                SelectionItem(
                  active: state.themeMode == ThemeMode.light,
                  title: KeyWork.light.tr,
                  onTap: () {
                    context.read<SettingBloc>().add(
                        SettingThemeModeChanged(themeMode: ThemeMode.light));
                    Get.back();
                  },
                ),
                Divider(height: 1.h, color: Colors.grey.shade300),
                SelectionItem(
                  active: state.themeMode == ThemeMode.dark,
                  title: KeyWork.dark.tr,
                  onTap: () {
                    context.read<SettingBloc>().add(
                        SettingThemeModeChanged(themeMode: ThemeMode.dark));
                    Get.back();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    Key? key,
    required this.active,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: SizedBox(
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyleUtils.regular(16),
                ),
              ),
              active ? Icon(Icons.check) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
