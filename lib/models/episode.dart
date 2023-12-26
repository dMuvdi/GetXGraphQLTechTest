class Episode {
  final String? id;
  final String? name;
  final String? airDate;
  final String? episode;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
  });

  factory Episode.fromMap({required Map map}) {
    return Episode(
      id: map['id'],
      name: map['name'],
      airDate: map['air_date'],
      episode: map['episode'],
    );
  }
}