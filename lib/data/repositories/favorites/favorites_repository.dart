import '../../models/character.dart';

abstract class FavoritesRepository {
  Future<List<Character>> getFavorites();
  Future<void> add(Character character);
  Future<void> remove(int id);
  bool isFavorite(int id);
}
