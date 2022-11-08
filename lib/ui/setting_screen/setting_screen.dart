import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/setting_bloc/setting_bloc.dart';
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/setting_screen/widgets/about_setting_screen.dart';
import 'package:budget_app/ui/setting_screen/widgets/payment_setting_screen.dart';
import 'package:budget_app/ui/setting_screen/widgets/category_setting_screen.dart';
import 'package:budget_app/ui/setting_screen/widgets/dark_mode_setting_screen.dart';
import 'package:budget_app/ui/setting_screen/widgets/erase_data_setting_screen.dart';
import 'package:budget_app/ui/setting_screen/widgets/language_setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_mail_app/open_mail_app.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            elevation: 0.8,
            child: BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SettingItem(
                      icon: Icons.language,
                      title: KeyWork.language.tr,
                      value: state.language == Language.vietnamese
                          ? KeyWork.vietnamese.tr
                          : KeyWork.english.tr,
                      onTap: () {
                        Get.to(() => LanguageSettingScreen());
                      },
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey.shade300,
                    ),
                    _SettingItem(
                      icon: CupertinoIcons.moon_circle_fill,
                      title: KeyWork.darkMode.tr,
                      value: state.themeMode == ThemeMode.dark
                          ? KeyWork.dark.tr
                          : state.themeMode == ThemeMode.light
                              ? KeyWork.light.tr
                              : KeyWork.system.tr,
                      onTap: () {
                        Get.to(() => DarkModeSettingScreen());
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 15.h),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            elevation: 0.8,
            child: BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SettingItem(
                      icon: Icons.wallet_rounded,
                      title: KeyWork.payment.tr,
                      value: '',
                      onTap: () {
                        Get.to(() => PaymentSettingScreen());
                      },
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey.shade300,
                    ),
                    _SettingItem(
                      icon: CupertinoIcons.square_list_fill,
                      title: KeyWork.category.tr,
                      value: '',
                      onTap: () {
                        Get.to(() => CategorySettingScreen());
                      },
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey.shade300,
                    ),
                    _SettingItem(
                      title: KeyWork.eraseData.tr,
                      icon: CupertinoIcons.clear_fill,
                      value: '',
                      onTap: () {
                        Get.to(() => EraseDataSettingScreen());
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 15.h),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            elevation: 0.8,
            child: BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SettingItem(
                      icon: Icons.mail,
                      title: KeyWork.contact.tr,
                      value: '',
                      onTap: () async {
                        var result = await OpenMailApp.composeNewEmailInMailApp(
                            emailContent: EmailContent(
                          to: ['huynn0105@gmail.com'],
                        ));
                        if (!result.didOpen && !result.canOpen) {
                          showNoMailAppsDialog(context);
                        } else if (!result.didOpen && result.canOpen) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MailAppPickerDialog(
                                mailApps: result.options,
                              );
                            },
                          );
                        }
                      },
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey.shade300,
                    ),
                    _SettingItem(
                      icon: CupertinoIcons.question_circle_fill,
                      title: KeyWork.about.tr,
                      value: '',
                      onTap: () {
                        Get.to(() => AboutSettingScreen());
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
                child: Text(
              title,
              style: TextStyleUtils.regular(16),
            )),
            Text(
              value,
              style: TextStyleUtils.regular(14),
            ),
            Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
