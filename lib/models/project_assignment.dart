import 'package:technical_test_mosofty/models/person.dart';
import 'package:technical_test_mosofty/models/project.dart';

class ProjectAssignment {
  Id id;
  Project project;
  Person person;

  ProjectAssignment({required this.id, required this.project, required this.person});

  factory ProjectAssignment.fromJson(Map<String, dynamic> json) {
    return ProjectAssignment(
      id: Id.fromJson(json['id']),
      project: Project.fromJson(json['projecto']),
      person: Person.fromJson(json['persono']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project': {'idpro': project.id},
      'list': [
        {'id': person.id, 'itemName': person.userName}
      ],
    };
  }
}

class Id {
  int? idpro;
  int? idperson;

  Id({required this.idpro, required this.idperson});

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      idpro: json['idpro'],
      idperson: json['idperson'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpro'] = this.idpro;
    data['idperson'] = this.idperson;
    return data;
  }
}
