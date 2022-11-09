// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_app/core/utils/enum_helper.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import 'package:budget_app/core/entities/base_entity.dart';

import 'budget_entity.dart';

@Entity()
// ignore: must_be_immutable
class SettingEntity extends BaseEntity {
  @override
  int id;
  @Transient()
  Language? language;
  @Transient()
  ThemeMode themeMode;
  var budget = ToOne<Budget>();

  SettingEntity({
    this.id = 0,
    this.language = Language.english,
    this.themeMode = ThemeMode.system,
  });

  set dbLanguage(int value) {
    _ensureStableEnumValues();
    language = Language.values[value];
    language = value >= 0 && value < Language.values.length
        ? Language.values[value]
        : Language.english;
  }

  int get dbLanguage {
    _ensureStableEnumValues();
    return language?.index ?? 0;
  }

  set dbThemeMode(int value) {
    _ensureStableEnumValues();
    themeMode = ThemeMode.values[value];
    themeMode = value >= 0 && value < ThemeMode.values.length
        ? ThemeMode.values[value]
        : ThemeMode.system;
  }

  int get dbThemeMode {
    _ensureStableEnumValues();
    return themeMode.index;
  }

  void _ensureStableEnumValues() {
    assert(Language.english.index == 0);
    assert(Language.vietnamese.index == 1);
    assert(ThemeMode.system.index == 0);
    assert(ThemeMode.light.index == 1);
    assert(ThemeMode.dark.index == 2);
  }

  @override
  List<Object?> get props => [
        themeMode,
        language,
      ];

  SettingEntity copyWith({
    int? id,
    Language? language,
    ThemeMode? themeMode,
    Budget? account,
  }) {
    return SettingEntity(
      id: id ?? this.id,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
    )..budget.target = account ?? this.budget.target;
  }
}
