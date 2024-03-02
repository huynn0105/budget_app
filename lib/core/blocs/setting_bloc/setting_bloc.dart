import 'package:bloc/bloc.dart';
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(
          SettingLoaded(
            themeMode: ThemeMode.light,
            language: Language.english,
          ),
        ) {
    on<SettingLanguageChanged>(
      (event, emit) {
      
      },
    );
    on<SettingThemeModeChanged>(
      (event, emit) {
        
      },
    );
  }
}
