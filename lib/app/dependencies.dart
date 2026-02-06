import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/data_sources/characters/characters_local_data_source.dart';
import '../data/data_sources/characters/characters_remote_data_source.dart';
import '../data/data_sources/favorites/favorites_local_data_source.dart';
import '../data/data_sources/settings/settings_local_data_source.dart';
import '../data/repositories/characters/characters_repository.dart';
import '../data/repositories/characters/characters_repository_impl.dart';
import '../data/repositories/favorites/favorites_repository.dart';
import '../data/repositories/favorites/favorites_repository_impl.dart';
import '../data/repositories/settings/settings_repository.dart';
import '../data/repositories/settings/settings_repository_impl.dart';

class AppDependencies {
  final CharactersRepository charactersRepository;
  final FavoritesRepository favoritesRepository;
  final SettingsRepository settingsRepository;

  AppDependencies({
    required this.charactersRepository,
    required this.favoritesRepository,
    required this.settingsRepository,
  });
}

Future<AppDependencies> initDependencies() async {
  await Hive.initFlutter();

  final charactersBox = await Hive.openBox('characters');
  final favoritesBox = await Hive.openBox('favorites');
  final settingsBox = await Hive.openBox('settings');

  final dio = Dio();

  return AppDependencies(
    charactersRepository: CharactersRepositoryImpl(
      remote: CharactersRemoteDataSource(dio),
      local: CharactersLocalDataSource(charactersBox),
    ),
    favoritesRepository: FavoritesRepositoryImpl(
      FavoritesLocalDataSource(favoritesBox),
    ),
    settingsRepository: SettingsRepositoryImpl(
      SettingsLocalDataSource(settingsBox),
    ),
  );
}
