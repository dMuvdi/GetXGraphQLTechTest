class Location {
  final String? id;
  final String? name;
  final String? type;
  final String? dimension;

  Location({
    this.id,
    this.name,
    this.type,
    this.dimension
  });

  factory Location.fromMap({required Map map}) {
    return Location(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Unknown',
      type: map['type'] ?? 'Unknown',
      dimension: map['dimension'] ?? 'Unknown'
    );
  }
}