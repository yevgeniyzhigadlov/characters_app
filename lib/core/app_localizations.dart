import 'package:flutter/widgets.dart';

import '../bloc/favorites/favorites_bloc.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final result =
        Localizations.of<AppLocalizations>(context, AppLocalizations);

    if (result != null) {
      return result;
    }

    return AppLocalizations(const Locale('ru'));
  }

  static const _localized = {
    'ru': {
      'characters': 'Персонажи',
      'favorites': 'Избранное',
      'settings': 'Настройки',
      'dark_theme': 'Тёмная тема',
      'language': 'Язык',
      'english': 'Английский',
      'russian': 'Русский',
      'no_favorites': 'Нет избранных персонажей',
      'error': 'Ошибка загрузки персонажей',
      'location': 'Локация',
      'episodes': 'Эпизоды',
      'alive': 'Жив',
      'dead': 'Мёртв',
      'unknown': 'Неизвестно',
      'male': 'Мужской',
      'female': 'Женский',
      'genderless': 'Бесполый',
      'human': 'Человек',
      'alien': 'Инопланетянин',
      'sort_by': 'Сортировать по',
      'sort_name': 'Имени',
      'sort_status': 'Статусу',
      'sort_species': 'Виду',
      'sort_episodes': 'Количеству эпизодов',
    },
    'en': {
      'characters': 'Characters',
      'favorites': 'Favorites',
      'settings': 'Settings',
      'dark_theme': 'Dark Theme',
      'language': 'Language',
      'english': 'English',
      'russian': 'Russian',
      'no_favorites': 'No favorites yet',
      'error': 'Failed to load characters',
      'location': 'Location',
      'episodes': 'Episodes',
      'alive': 'Alive',
      'dead': 'Dead',
      'unknown': 'Unknown',
      'male': 'Male',
      'female': 'Female',
      'genderless': 'Genderless',
      'human': 'Human',
      'alien': 'Alien',
      'sort_by': 'Sort by',
      'sort_name': 'Name',
      'sort_status': 'Status',
      'sort_species': 'Species',
      'sort_episodes': 'Count of episodes',
    },
  };

  String t(String key) => _localized[locale.languageCode]?[key] ?? key;

  String status(String value) {
    switch (value.toLowerCase()) {
      case 'alive':
        return t('alive');
      case 'dead':
        return t('dead');
      default:
        return t('unknown');
    }
  }

  String gender(String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return t('male');
      case 'female':
        return t('female');
      case 'genderless':
        return t('genderless');
      default:
        return value;
    }
  }

  String species(String value) {
    switch (value.toLowerCase()) {
      case 'human':
        return t('human');
      case 'alien':
        return t('alien');
      default:
        return value;
    }
  }

  String sort(FavoritesSort sort) {
    switch (sort) {
      case FavoritesSort.name:
        return t('sort_name');
      case FavoritesSort.status:
        return t('sort_status');
      case FavoritesSort.species:
        return t('sort_species');
      case FavoritesSort.episodes:
        return t('sort_episodes');
    }
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_) => false;
}
