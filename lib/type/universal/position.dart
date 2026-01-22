class Position {
  final double? positionLon;
  final double? positionLat;
  final String? geoHash;
  Position({this.positionLon, this.positionLat, this.geoHash});
  static Position? fromMap(Map<String, dynamic>? json) {
    return json == null
        ? null
        : Position(
            positionLon: (json['PositionLon'] as num?)?.toDouble(),
            positionLat: (json['PositionLat'] as num?)?.toDouble(),
            geoHash: json['GeoHash'] as String?,
          );
  }
}
