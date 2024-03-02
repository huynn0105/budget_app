import 'package:expense_manager/core/entities/budget_entity.dart';
import 'package:expense_manager/core/entities/setting_entity.dart';
import 'package:expense_manager/core/utils/enum_helper.dart';
import 'package:flutter/material.dart';

abstract class ISettingService {
  SettingEntity getCurrentSetting();
  void changeLanguage(Language language);
  void changeThemeMode(ThemeMode themeMode);
  void changeAccount(Budget account);
}
