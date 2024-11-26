class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(lat: json["lat"], lng: json["lat"]);
  }
}

class User {
  final String name;
  final Location location;
  User({
    required this.name,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json["name"],
        location: json["location"] != null
            ? Location.fromJson(json)
            : Location(lat: 0.0, lng: 0.0));
  }
}
