import 'package:expense_manager/core/blocs/setting_bloc/setting_bloc.dart';
import 'package:expense_manager/core/utils/enum_helper.dart';
import 'package:expense_manager/ui/setting_screen/widgets/dark_mode_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../translation/keyword.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          KeyWork.language.tr,
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
                  active: state.language == Language.english,
                  title: 'English',
                  onTap: () {
                    context.read<SettingBloc>().add(
                        SettingLanguageChanged(language: Language.english));
                    Get.back();
                  },
                ),
                Divider(height: 1.h, color: Colors.grey.shade300),
                SelectionItem(
                  active: state.language == Language.vietnamese,
                  title: 'Tiếng Việt',
                  onTap: () {
                    context.read<SettingBloc>().add(
                        SettingLanguageChanged(language: Language.vietnamese));
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
