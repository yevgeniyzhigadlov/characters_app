
part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final Character character;
  ToggleFavorite(this.character);

  @override
  List<Object?> get props => [character];
}

class ChangeSort extends FavoritesEvent {
  final FavoritesSort sort;
  ChangeSort(this.sort);

  @override
  List<Object?> get props => [sort];
}
