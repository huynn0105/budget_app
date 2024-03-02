import 'package:expense_manager/translation/app_translation.dart';
import 'package:expense_manager/translation/keyword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Language {
  english,
  vietnamese,
}

class EnumHelper {
  static String getDescription<T>(Map<T, String> enumMap, T myEnum) {
    if (myEnum == null) {
      return '';
    }
    var a = AppTranslation.isVn();
    print(a);
    return enumMap[myEnum]!;
  }
}

class EnumMap {
  static Map<Language, String> langage = {
    Language.english: KeyWork.english.tr,
    Language.vietnamese: 'Tiếng Việt',
  };
  static Map<ThemeMode, String> themeMode = {
    ThemeMode.system: KeyWork.system.tr,
    ThemeMode.dark: KeyWork.dark.tr,
    ThemeMode.light: KeyWork.light.tr,
  };
}
