part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  final Language language;
  final ThemeMode themeMode;
  const SettingState({
    required this.language,
    required this.themeMode,
  });

  @override
  List<Object> get props => [language, themeMode];
}

class SettingLoaded extends SettingState {
  const SettingLoaded({
    required Language language,
    required ThemeMode themeMode,
  }) : super(themeMode: themeMode, language: language);

  @override
  List<Object> get props => [language, themeMode];
}

