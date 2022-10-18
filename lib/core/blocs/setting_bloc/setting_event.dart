part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SettingLanguageChanged extends SettingEvent {
  final Language language;
  const SettingLanguageChanged({
    required this.language,
  });
  @override
  List<Object> get props => [language];
}

class SettingThemeModeChanged extends SettingEvent {
  final ThemeMode themeMode;
  const SettingThemeModeChanged({
    required this.themeMode,
  });
    @override
  List<Object> get props => [themeMode];
}
