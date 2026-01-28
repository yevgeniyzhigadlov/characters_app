import 'package:flutter/material.dart';
import '../../../core/app_localizations.dart';
import '../characters/characters_screen.dart';
import '../favorites/favorites_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final screens = const [
      CharactersScreen(),
      FavoritesScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: loc.t('characters')),
          BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: loc.t('favorites')),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: loc.t('settings')),
        ],
      ),
    );
  }
}
