
part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final List<Character> favorites;
  final FavoritesSort sort;

  const FavoritesState(this.favorites, this.sort);

  FavoritesState copyWith({
    List<Character>? favorites,
    FavoritesSort? sort,
  }) {
    return FavoritesState(
      favorites ?? this.favorites,
      sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [favorites, sort];
}
