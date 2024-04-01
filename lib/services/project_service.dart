import 'dart:convert';
import 'package:technical_test_mosofty/models/person.dart';
import 'package:http/http.dart' as http;
import 'package:technical_test_mosofty/models/project.dart';
import 'package:technical_test_mosofty/models/project_assignment.dart';

class ProjectService {
  Future<Person?> postProject(Project newProject) async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/projects/create");

    dynamic res = await http.post(
      myUri,
      body: jsonEncode(newProject.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return Person.fromJson(body['data']);
    } else {
      print("Can't add person");
      return null;
    }
  }

  Future<List<Project>> getProjects() async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/projects");

    dynamic res = await http.get(myUri);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      List<Project> projects = [];

      for (var item in body) {
        projects.add(Project.fromJson(item));
      }

      return projects;
    } else {
      print("can't get projects");
      return [];
    }
  }

  Future<List<ProjectAssignment>> getProjectsDone() async {
    Uri myUri = Uri.parse("http://104.225.216.185:9306/projectsdone/all");

    dynamic res = await http.get(myUri);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      List<ProjectAssignment> projectAssignments = [];

      for (var item in body) {
        projectAssignments.add(ProjectAssignment.fromJson(item));
      }

      return projectAssignments;
    } else {
      print("can't get project Assignments");
      return [];
    }
  }
}
