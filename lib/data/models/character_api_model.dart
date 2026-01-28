class CharacterApiModel {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;
  final String location;
  final int episodeCount;

  CharacterApiModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.location,
    required this.episodeCount,
  });

  factory CharacterApiModel.fromJson(Map<String, dynamic> json) {
    return CharacterApiModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      location: json['location']['name'],
      episodeCount: (json['episode'] as List).length,
    );
  }
}