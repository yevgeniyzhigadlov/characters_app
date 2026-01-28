import 'package:flutter/material.dart';

abstract class SettingsRepository {
  bool loadTheme();
  Future<void> saveTheme(bool isDark);

  Locale loadLocale();
  Future<void> saveLocale(Locale locale);
}
