import 'location.dart';
import 'episode.dart';

class Character {
  final String? id;
  final String name;
  final String? status;
  final DateTime? created;
  final String? species;
  final String? type;
  final String? gender;
  final Location? origin;
  final Location? location;
  final String image;
  final List<Episode>? episodes; 

  Character({
    this.id,
    required this.name, 
    this.status,
    this.created,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    required this.image,
    this.episodes
  });

  factory Character.fromMap({required Map map}) {
    return Character(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      created: DateTime.parse(map['created']),
      species: map['species'],
      type: map['type'],
      gender: map['gender'],
      origin: Location.fromMap(map: map['origin']),
      location: Location.fromMap(map: map['location']),
      image: map['image'],
      episodes: map['episode'] != null ? (map['episode'] as List).map((episode) => Episode.fromMap(map: episode)).toList() : []
    );
  }
}