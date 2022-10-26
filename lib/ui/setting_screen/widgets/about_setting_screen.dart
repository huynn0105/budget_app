import 'package:budget_app/constants.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutSettingScreen extends StatelessWidget {
  const AboutSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyWork.about.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Image.asset(
              'assets/images/logo.png',
              width: 80.r,
              height: 80.r,
            ),
            SizedBox(height: 15.h),
            Text(
              '${KeyWork.version.tr} 1.0.0',
              style: TextStyleUtils.regular(16),
            ),
            SizedBox(height: 20.h),
            Text(
              'Made with ❤ by @huynn0105',
              style: TextStyleUtils.regular(16),
            ),
          ],
        ),
      ),
    );
  }
}
