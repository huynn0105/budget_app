import 'package:expense_manager/core/database/daos/setting_dao.dart';
import 'package:expense_manager/core/entities/budget_entity.dart';
import 'package:expense_manager/core/entities/setting_entity.dart';
import 'package:expense_manager/core/services/interfaces/isetting_service.dart';
import 'package:expense_manager/core/utils/enum_helper.dart';
import 'package:expense_manager/global/locator.dart';
import 'package:flutter/src/material/app.dart';

class SettingService implements ISettingService {
  final _settingDao = locator<SettingDao>();

  @override
  SettingEntity getCurrentSetting() {
    return _settingDao.getCurrentSetting();
  }

  @override
  void changeLanguage(Language language) {
    var currentSetting = _settingDao.getCurrentSetting();
    final newCurrentSetting = currentSetting.copyWith(language: language);
    _settingDao.update(newCurrentSetting);
  }

  @override
  void changeThemeMode(ThemeMode themeMode) {
    var currentSetting = _settingDao.getCurrentSetting();
    final newCurrentSetting = currentSetting.copyWith(themeMode: themeMode);
    _settingDao.update(newCurrentSetting);
  }

  @override
  void changeAccount(Budget account) {
    var currentSetting = _settingDao.getCurrentSetting();
    final newCurrentSetting = currentSetting.copyWith(account: account);
    _settingDao.update(newCurrentSetting);
  }
}
