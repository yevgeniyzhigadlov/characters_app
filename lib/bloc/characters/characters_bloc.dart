import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/character.dart';
import '../../data/repositories/characters/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository repository;

  CharactersBloc(this.repository) : super(CharactersState.initial()) {
    on<LoadCharacters>(_load);
    on<LoadNextPage>(_loadNext);
    on<RefreshCharacters>(_refresh);
  }

  Future<void> _load(
      LoadCharacters event,
      Emitter<CharactersState> emit,
      ) async {
    emit(state.copyWith(
      status: CharactersStatus.loading,
      page: 1,
      hasReachedEnd: false,
      isLoadingNext: false,
    ));

    try {
      final list = await repository.getCharacters(1);

      emit(state.copyWith(
        characters: list,
        status: CharactersStatus.loaded,
        page: 1,
        hasReachedEnd: list.isEmpty,
      ));
    } catch (_) {
      emit(state.copyWith(status: CharactersStatus.error));
    }
  }

  Future<void> _loadNext(
      LoadNextPage event,
      Emitter<CharactersState> emit,
      ) async {
    if (state.status != CharactersStatus.loaded) return;
    if (state.isLoadingNext) return;
    if (state.hasReachedEnd) return;

    emit(state.copyWith(isLoadingNext: true));

    try {
      final nextPage = state.page + 1;
      final list = await repository.getCharacters(nextPage);

      if (list.isEmpty) {
        emit(state.copyWith(
          isLoadingNext: false,
          hasReachedEnd: true,
        ));
        return;
      }

      emit(state.copyWith(
        characters: [...state.characters, ...list],
        page: nextPage,
        isLoadingNext: false,
        status: CharactersStatus.loaded,
      ));
    } catch (_) {
      emit(state.copyWith(isLoadingNext: false));
    }
  }

  Future<void> _refresh(
      RefreshCharacters event,
      Emitter<CharactersState> emit,
      ) async {
    add(LoadCharacters());
  }
}

