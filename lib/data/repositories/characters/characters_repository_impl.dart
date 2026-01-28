import '../../data_sources/characters/characters_local_data_source.dart';
import '../../data_sources/characters/characters_remote_data_source.dart';
import '../../models/character.dart';
import '../../models/character_db_model.dart';
import 'characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource remote;
  final CharactersLocalDataSource local;

  CharactersRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<Character>> getCharacters(int page) async {
    try {
      final apiModels = await remote.getCharacters(page);

      final dbModels =
      apiModels.map((e) => CharacterDBModel.fromApi(e)).toList();

      await local.savePage(page, dbModels);

      return dbModels.map((e) => e.toDomain()).toList();
    } catch (_) {
      final cached = local.loadPage(page);
      if (cached != null) {
        return cached.map((e) => e.toDomain()).toList();
      }
      rethrow;
    }
  }
}
