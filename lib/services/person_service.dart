import 'dart:convert';
import 'package:technical_test_mosofty/models/person.dart';
import 'package:http/http.dart' as http;
import 'package:technical_test_mosofty/models/project_assignment.dart';

class PersonService {
  Future<Person?> postPerson(Person newPerson) async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/persons/new");
    dynamic res = await http.post(
      myUri,
      body: jsonEncode(newPerson.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      return Person.fromJson(body);
    } else {
      print("Can't add person");
      return null;
    }
  }

  Future<Person?> updatePerson(Person newPerson) async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/persons/upuserr/${newPerson.id}");
    dynamic res = await http.put(
      myUri,
      body: jsonEncode(newPerson.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return Person.fromJson(body);
    } else {
      print("Can't update person");
      return null;
    }
  }

  Future<Person?> getOnePerson(int id) async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/persons/$id");

    dynamic res = await http.get(myUri);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return Person.fromJson(body);
    } else {
      return null;
    }
  }

  Future<List<Person>> getPersons() async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/persons");

    dynamic res = await http.get(myUri);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      List<Person> persons = [];

      for (var item in body) {
        persons.add(Person.fromJson(item));
      }

      return persons;
    } else {
      print("can't get persons");
      return [];
    }
  }

  Future<void> AssignProjectToPerson(ProjectAssignment projectPerson) async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/projectsdone/UsersProject");

    dynamic res = await http.post(
      myUri,
      body: jsonEncode(projectPerson.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200 || res.statusCode == 202) {
      print("Project Assigned");
    } else {
      print("Can't assign project");
      throw Exception();
    }
  }
}
