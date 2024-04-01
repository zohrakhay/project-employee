class Person {
  int? id;
  String lastName;
  String firstName;
  String userName;
  String email;

  Person({
     this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': lastName,
      'prenom': firstName,
      'mail': email,
      'username': userName,
    };
  }

  Person.fromJson(Map<String, dynamic> json)
      : lastName = json['nom'],
        firstName = json['prenom'],
        userName = json['username'],
        email = json['mail'];
}
