import 'package:hive/hive.dart';
import 'package:characters_app/data/models/character_db_model.dart';

class CharactersLocalDataSource {
  final Box box;

  CharactersLocalDataSource(this.box);

  Future<void> savePage(int page, List<CharacterDBModel> characters) async {
    await box.put(
      'page_$page',
      characters.map((e) => e.toJson()).toList(),
    );
  }

  List<CharacterDBModel>? loadPage(int page) {
    final raw = box.get('page_$page');
    if (raw is List) {
      return raw
          .map((e) => CharacterDBModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();
    }
    return null;
  }
}
