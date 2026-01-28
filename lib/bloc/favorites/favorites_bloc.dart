import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/character.dart';
import '../../data/repositories/favorites/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

enum FavoritesSort { name, status, species, episodes }

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository)
      : super(const FavoritesState([], FavoritesSort.name)) {
    on<LoadFavorites>(_load);
    on<ToggleFavorite>(_toggle);
    on<ChangeSort>(_changeSort);
  }

  Future<void> _load(LoadFavorites event, Emitter<FavoritesState> emit) async {
    final list = await repository.getFavorites();
    emit(state.copyWith(favorites: _sort(list, state.sort)));
  }

  Future<void> _toggle(
      ToggleFavorite event,
      Emitter<FavoritesState> emit,
      ) async {
    final isFav = repository.isFavorite(event.character.id);

    if (isFav) {
      await repository.remove(event.character.id);
    } else {
      await repository.add(event.character);
    }

    final list = await repository.getFavorites();
    emit(state.copyWith(favorites: _sort(list, state.sort)));
  }

  void _changeSort(ChangeSort event, Emitter<FavoritesState> emit) {
    emit(state.copyWith(
      sort: event.sort,
      favorites: _sort(state.favorites, event.sort),
    ));
  }

  List<Character> _sort(List<Character> list, FavoritesSort sort) {
    final sorted = List<Character>.from(list);

    switch (sort) {
      case FavoritesSort.name:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;

      case FavoritesSort.status:
        sorted.sort((a, b) => a.status.compareTo(b.status));
        break;

      case FavoritesSort.species:
        sorted.sort((a, b) => a.species.compareTo(b.species));
        break;

      case FavoritesSort.episodes:
        sorted.sort((a, b) => b.episodeCount.compareTo(a.episodeCount));
        break;
    }

    return sorted;
  }
}