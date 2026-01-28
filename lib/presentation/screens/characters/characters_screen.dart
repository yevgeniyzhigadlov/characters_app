import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/characters/characters_bloc.dart';
import '../../../core/app_localizations.dart';
import '../../widgets/character_card.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 200) {
        context.read<CharactersBloc>().add(LoadNextPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state.status == CharactersStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == CharactersStatus.error) {
          return Center(child: Text(loc.t('error')));
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<CharactersBloc>().add(RefreshCharacters());
          },
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: ListView.builder(
                controller: controller,
                itemCount: state.characters.length,
                itemBuilder: (_, i) {
                  return CharacterCard(character: state.characters[i]);
                },
              )),
        );
      },
    );
  }
}
