import 'package:budget_app/core/entities/setting_entity.dart';
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:flutter/material.dart';

abstract class ISettingService {
  SettingEntity getCurrentSetting();
  void changeLanguage(Language language);
  void changeThemeMode(ThemeMode themeMode);
}
