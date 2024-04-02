class Project {
  int? id;
  String name;
  String description;
  String longitude;
  String latitude;

  Project({
    this.id,
    required this.name,
    required this.description,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': name,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  Project.fromJson(Map<String, dynamic> json)
      : id = json['idpro'],
        name = json['nom'],
        description = json['description'],
        longitude = json['longitude'],
        latitude = json['latitude'];
}
