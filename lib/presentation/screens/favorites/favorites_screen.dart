import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/favorites/favorites_bloc.dart';
import '../../../core/app_localizations.dart';
import '../../widgets/character_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SafeArea(
        child: Column(
      children: [
        BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.t('sort_by'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DropdownButton<FavoritesSort>(
                    value: state.sort,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<FavoritesBloc>().add(ChangeSort(value));
                      }
                    },
                    items: FavoritesSort.values.map((sort) {
                      return DropdownMenuItem(
                        value: sort,
                        child: Text(loc.sort(sort)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state.favorites.isEmpty) {
                return Center(child: Text(loc.t('no_favorites')));
              }
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: ListView.builder(
                    itemCount: state.favorites.length,
                    itemBuilder: (_, i) {
                      return CharacterCard(character: state.favorites[i]);
                    },
                  ));
            },
          ),
        ),
      ],
    ));
  }
}
