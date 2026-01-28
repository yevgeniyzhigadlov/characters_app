import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:characters_app/presentation/screens/main/main_screen.dart';

import 'bloc/characters/characters_bloc.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'bloc/locale/locale_cubit.dart';
import 'bloc/theme/theme_cubit.dart';
import 'data/data_sources/characters/characters_local_data_source.dart';
import 'data/data_sources/characters/characters_remote_data_source.dart';
import 'data/data_sources/favorites/favorites_local_data_source.dart';
import 'data/data_sources/settings/settings_local_data_source.dart';
import 'data/repositories/characters/characters_repository_impl.dart';
import 'data/repositories/favorites/favorites_repository_impl.dart';
import 'core/app_localizations.dart';
import 'data/repositories/settings/settings_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cache');
  await Hive.openBox('favorites');
  await Hive.openBox('settings');

  final dio = Dio();
  final charactersBox = await Hive.openBox('characters');
  final charactersLocal = CharactersLocalDataSource(charactersBox);
  final charactersRemote = CharactersRemoteDataSource(dio);
  final charactersRepository = CharactersRepositoryImpl(
    remote: charactersRemote,
    local: charactersLocal,
  );

  final favoritesBox = Hive.box('favorites');
  final favoritesLocal = FavoritesLocalDataSource(favoritesBox);
  final favoritesRepository = FavoritesRepositoryImpl(favoritesLocal);

  final settingsBox = await Hive.openBox('settings');
  final settingsLocal = SettingsLocalDataSource(settingsBox);
  final settingsRepository = SettingsRepositoryImpl(settingsLocal);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                CharactersBloc(charactersRepository)..add(LoadCharacters())),
        BlocProvider(
            create: (_) =>
                FavoritesBloc(favoritesRepository)..add(LoadFavorites())),
        BlocProvider(create: (_) => ThemeCubit(settingsRepository)),
        BlocProvider(create: (_) => LocaleCubit(settingsRepository))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;

    return MaterialApp(
      locale: locale,
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
