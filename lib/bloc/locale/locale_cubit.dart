import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/settings/settings_repository.dart';

class LocaleCubit extends Cubit<Locale> {
  final SettingsRepository repo;

  LocaleCubit(this.repo) : super(repo.loadLocale());

  void change(Locale locale) {
    repo.saveLocale(locale);
    emit(locale);
  }
}
