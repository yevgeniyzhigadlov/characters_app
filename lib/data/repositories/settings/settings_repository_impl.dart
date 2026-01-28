import 'package:characters_app/data/repositories/settings/settings_repository.dart';
import 'package:flutter/material.dart';
import '../../data_sources/settings/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource local;

  SettingsRepositoryImpl(this.local);

  @override
  bool loadTheme() {
    return local.loadTheme();
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    await local.saveTheme(isDark);
  }

  @override
  Locale loadLocale() {
    return local.loadLocale();
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await local.saveLocale(locale);
  }
}
