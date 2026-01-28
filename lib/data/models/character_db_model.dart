import 'character.dart';
import 'character_api_model.dart';

class CharacterDBModel {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;
  final String location;
  final int episodeCount;

  CharacterDBModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.location,
    required this.episodeCount,
  });

  factory CharacterDBModel.fromDomain(Character c) {
    return CharacterDBModel(
      id: c.id,
      name: c.name,
      image: c.image,
      status: c.status,
      species: c.species,
      gender: c.gender,
      location: c.location,
      episodeCount: c.episodeCount,
    );
  }

  factory CharacterDBModel.fromJson(Map<String, dynamic> json) {
    return CharacterDBModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      location: json['location'],
      episodeCount: json['episodeCount'],
    );
  }

  factory CharacterDBModel.fromApi(CharacterApiModel api) {
    return CharacterDBModel(
      id: api.id,
      name: api.name,
      status: api.status,
      species: api.species,
      gender: api.gender,
      image: api.image,
      location: api.location,
      episodeCount: api.episodeCount,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'status': status,
    'species': species,
    'gender': gender,
    'location': location,
    'episodeCount': episodeCount,
  };

  Character toDomain() {
    return Character(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
      gender: gender,
      location: location,
      episodeCount: episodeCount,
    );
  }
}
