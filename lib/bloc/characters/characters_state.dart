part of 'characters_bloc.dart';

enum CharactersStatus { initial, loading, loaded, error }

class CharactersState extends Equatable {
  final List<Character> characters;
  final CharactersStatus status;

  const CharactersState({
    required this.characters,
    required this.status,
  });

  factory CharactersState.initial() {
    return const CharactersState(
      characters: [],
      status: CharactersStatus.initial,
    );
  }

  CharactersState copyWith({
    List<Character>? characters,
    CharactersStatus? status,
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [characters, status];
}