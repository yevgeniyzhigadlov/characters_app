import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../bloc/characters/characters_bloc.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../bloc/locale/locale_cubit.dart';

import '../core/app_localizations.dart';
import '../presentation/screens/main/main_screen.dart';
import 'dependencies.dart';

class App extends StatelessWidget {
  final AppDependencies dependencies;

  const App({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          CharactersBloc(dependencies.charactersRepository)..add(LoadCharacters()),
        ),
        BlocProvider(
          create: (_) =>
          FavoritesBloc(dependencies.favoritesRepository)..add(LoadFavorites()),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(dependencies.settingsRepository),
        ),
        BlocProvider(
          create: (_) => LocaleCubit(dependencies.settingsRepository),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

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