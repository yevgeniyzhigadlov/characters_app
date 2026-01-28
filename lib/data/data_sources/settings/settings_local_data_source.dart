import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsLocalDataSource {
  final Box box;

  SettingsLocalDataSource(this.box);

  bool loadTheme() {
    return box.get('isDark', defaultValue: false);
  }

  Future<void> saveTheme(bool isDark) async {
    await box.put('isDark', isDark);
  }

  Locale loadLocale() {
    final code = box.get('language', defaultValue: 'en');
    return Locale(code);
  }

  Future<void> saveLocale(Locale locale) async {
    await box.put('language', locale.languageCode);
  }
}
