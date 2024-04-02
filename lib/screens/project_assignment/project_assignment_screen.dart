import 'package:flutter/material.dart';
import 'package:technical_test_mosofty/models/person.dart';
import 'package:technical_test_mosofty/models/project.dart';
import 'package:technical_test_mosofty/models/project_assignment.dart';
import 'package:technical_test_mosofty/services/person_service.dart';
import 'package:technical_test_mosofty/services/project_service.dart';

class ProjectAssignmentPage extends StatefulWidget {
  const ProjectAssignmentPage({super.key});

  @override
  State<ProjectAssignmentPage> createState() => _ProjectAssignmentPageState();
}

class _ProjectAssignmentPageState extends State<ProjectAssignmentPage> {
  List<Project> projects = [];
  List<Person> persons = [];
  Person? selectedPerson;
  Project? selectedProject;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProjects();
    getPersons();
  }

  Future<void> getPersons() async {
    List<Person> fetchedPersons = await PersonService().getPersons();

    setState(() {
      persons = fetchedPersons;
      isLoading = false;
    });
  }

  Future<void> getProjects() async {
    List<Project> fetchedProjects = await ProjectService().getProjects();
    setState(() {
      projects = fetchedProjects;
      isLoading = false;
    });
  }

  Future<void> _assignProjectToPerson(Project project, Person person) async {
    ProjectAssignment newAssignment =
        ProjectAssignment(id: Id(idpro: project.id, idperson: person.id), project: project, person: person);
    try {
      await PersonService().AssignProjectToPerson(newAssignment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Projet affecté avec succès!'),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur s\'est produite'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Lier un projet à un employé'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Projet'),
                  DropdownButton<Project>(
                    items: projects.map((Project project) {
                      return DropdownMenuItem<Project>(
                        value: project,
                        child: Text(project.name),
                      );
                    }).toList(),
                    onChanged: (Project? selected) {
                      setState(() {
                        selectedProject = selected!;
                      });
                    },
                    hint: selectedProject != null ? Text('${selectedProject!.name} ') : Text('Choisissez un projet '),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Employé'),
                  DropdownButton<Person>(
                    items: persons.map((Person person) {
                      return DropdownMenuItem<Person>(
                        value: person,
                        child: Text(person.userName),
                      );
                    }).toList(),
                    onChanged: (Person? selected) {
                      setState(() {
                        selectedPerson = selected!;
                      });
                    },
                    hint: selectedPerson != null ? Text('${selectedPerson!.userName}') : Text('Choisissez un employé'),
                  ),
                ],
              )),
          ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
              onPressed: () {
                _assignProjectToPerson(selectedProject!, selectedPerson!);
                Navigator.pop(context);
              },
              child: Text("Enregistrer"))
        ],
      ),
    );
  }
}
