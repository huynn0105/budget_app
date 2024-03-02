import 'package:bloc/bloc.dart';
import 'package:expense_manager/core/services/interfaces/isetting_service.dart';
import 'package:expense_manager/core/utils/enum_helper.dart';
import 'package:expense_manager/global/locator.dart';
import 'package:expense_manager/translation/app_translation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final _settingService = locator<ISettingService>();
  SettingBloc()
      : super(
          SettingLoaded(
            themeMode: locator<ISettingService>().getCurrentSetting().themeMode,
            language: locator<ISettingService>().getCurrentSetting().language!,
          ),
        ) {
    on<SettingLanguageChanged>(
      (event, emit) {
        _settingService.changeLanguage(event.language);
        AppTranslation.switchLanguage(event.language);
        final currentSetting = _settingService.getCurrentSetting();
        emit(
          SettingLoaded(
            themeMode: currentSetting.themeMode,
            language: currentSetting.language!,
          ),
        );
      },
    );
    on<SettingThemeModeChanged>(
      (event, emit) {
        _settingService.changeThemeMode(event.themeMode);
        final currentSetting = _settingService.getCurrentSetting();
        emit(
          SettingLoaded(
            themeMode: currentSetting.themeMode,
            language: currentSetting.language!,
          ),
        );
      },
    );
  }
}
