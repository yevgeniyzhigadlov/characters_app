import '../../data_sources/favorites/favorites_local_data_source.dart';
import '../../models/character.dart';
import '../../models/character_db_model.dart';
import 'favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource local;

  FavoritesRepositoryImpl(this.local);

  @override
  Future<List<Character>> getFavorites() async {
    final cacheList = await local.getFavorites();
    return cacheList.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> add(Character character) async {
    await local.saveFavorite(
      CharacterDBModel.fromDomain(character),
    );
  }

  @override
  Future<void> remove(int id) async {
    await local.removeFavorite(id);
  }

  @override
  bool isFavorite(int id) {
    return local.isFavorite(id);
  }
}
