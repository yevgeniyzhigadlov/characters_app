import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/character.dart';
import '../../data/repositories/characters/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository repository;
  int page = 1;

  CharactersBloc(this.repository) : super(CharactersState.initial()) {
    on<LoadCharacters>(_load);
    on<LoadNextPage>(_loadNext);
    on<RefreshCharacters>(_refresh);
  }

  Future<void> _load(
      LoadCharacters event,
      Emitter<CharactersState> emit,
      ) async {
    emit(state.copyWith(status: CharactersStatus.loading));

    try {
      page = 1;
      final list = await repository.getCharacters(page);

      emit(state.copyWith(
        characters: list,
        status: CharactersStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: CharactersStatus.error));
    }
  }

  Future<void> _loadNext(
      LoadNextPage event,
      Emitter<CharactersState> emit,
      ) async {
    try {
      page++;
      final list = await repository.getCharacters(page);

      emit(state.copyWith(
        characters: [...state.characters, ...list],
        status: CharactersStatus.loaded,
      ));
    } catch (_) {}
  }

  Future<void> _refresh(
      RefreshCharacters event,
      Emitter<CharactersState> emit,
      ) async {
    page = 1;
    add(LoadCharacters());
  }
}
