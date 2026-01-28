import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/locale/locale_cubit.dart';
import '../../../bloc/theme/theme_cubit.dart';
import '../../../core/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;
    final loc = AppLocalizations.of(context);

    return SafeArea(
        child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: Text(loc.t('dark_theme')),
          value: isDark,
          onChanged: (_) => context.read<ThemeCubit>().toggle(),
        ),
        const Divider(),
        ListTile(
          title: Text(loc.t('language')),
          trailing: DropdownButton<Locale>(
            value: locale,
            onChanged: (value) {
              if (value != null) {
                context.read<LocaleCubit>().change(value);
              }
            },
            items: [
              DropdownMenuItem(
                value: const Locale('en'),
                child: Text(loc.t('english')),
              ),
              DropdownMenuItem(
                value: const Locale('ru'),
                child: Text(loc.t('russian')),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
