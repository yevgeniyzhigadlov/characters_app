part of 'characters_bloc.dart';

enum CharactersStatus { initial, loading, loaded, error }

class CharactersState extends Equatable {
  final List<Character> characters;
  final CharactersStatus status;

  final int page;
  final bool isLoadingNext;
  final bool hasReachedEnd;

  const CharactersState({
    required this.characters,
    required this.status,
    required this.page,
    required this.isLoadingNext,
    required this.hasReachedEnd,
  });

  factory CharactersState.initial() => const CharactersState(
    characters: [],
    status: CharactersStatus.initial,
    page: 1,
    isLoadingNext: false,
    hasReachedEnd: false,
  );

  CharactersState copyWith({
    List<Character>? characters,
    CharactersStatus? status,
    int? page,
    bool? isLoadingNext,
    bool? hasReachedEnd,
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      status: status ?? this.status,
      page: page ?? this.page,
      isLoadingNext: isLoadingNext ?? this.isLoadingNext,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props =>
      [characters, status, page, isLoadingNext, hasReachedEnd];
}
