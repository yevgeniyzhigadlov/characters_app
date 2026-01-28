import 'package:dio/dio.dart';
import '../../models/character_api_model.dart';

class CharactersRemoteDataSource {
  final Dio dio;

  CharactersRemoteDataSource(this.dio);

  Future<List<CharacterApiModel>> getCharacters(int page) async {
    final response = await dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: {'page': page},
    );

    final results = response.data['results'] as List;

    return results
        .map((e) => CharacterApiModel.fromJson(e))
        .toList();
  }
}
