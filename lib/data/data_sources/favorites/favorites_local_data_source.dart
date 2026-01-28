import 'package:hive/hive.dart';
import '../../models/character_db_model.dart';

class FavoritesLocalDataSource {
  final Box box;

  FavoritesLocalDataSource(this.box);

  Future<List<CharacterDBModel>> getFavorites() async {
    return box.values
        .map((e) => CharacterDBModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveFavorite(CharacterDBModel model) async {
    await box.put(model.id, model.toJson());
  }

  Future<void> removeFavorite(int id) async {
    await box.delete(id);
  }

  bool isFavorite(int id) {
    return box.containsKey(id);
  }
}
