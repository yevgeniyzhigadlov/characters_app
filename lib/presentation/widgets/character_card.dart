import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/favorites/favorites_bloc.dart';
import '../../core/app_localizations.dart';
import '../../data/models/character.dart';

class CharacterCard extends StatefulWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _prevIsFav = false;

  @override
  void initState() {
    super.initState();

    final favorites = context.read<FavoritesBloc>().state.favorites;
    _prevIsFav = favorites.any((e) => e.id == widget.character.id);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: _prevIsFav ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant CharacterCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    final favorites = context.read<FavoritesBloc>().state.favorites;
    final isFav = favorites.any((e) => e.id == widget.character.id);

    if (isFav != _prevIsFav) {
      if (isFav) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _prevIsFav = isFav;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesBloc>().state.favorites;
    final isFav = favorites.any((e) => e.id == widget.character.id);
    final loc = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.character.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.character.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${loc.status(widget.character.status)} • '
                        '${loc.species(widget.character.species)} • '
                        '${loc.gender(widget.character.gender)}',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${loc.t('location')}: ${widget.character.location}',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${loc.t('episodes')}: ${widget.character.episodeCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.3).animate(_controller),
              child: IconButton(
                icon: Icon(
                  isFav ? Icons.star : Icons.star_border,
                  color: isFav ? Colors.amber : null,
                ),
                onPressed: () {
                  context
                      .read<FavoritesBloc>()
                      .add(ToggleFavorite(widget.character));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
