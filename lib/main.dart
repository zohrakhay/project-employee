import 'package:flutter/material.dart';
import 'package:technical_test_mosofty/screens/persons/add_person_screen.dart';
import 'package:technical_test_mosofty/screens/persons/person_list_page.dart';
import 'package:technical_test_mosofty/screens/persons/update_person_screen.dart';
import 'package:technical_test_mosofty/screens/project/add_project_screen.dart';
import 'package:technical_test_mosofty/screens/project/project_list_page.dart';
import 'package:technical_test_mosofty/screens/project_assignment/project_assignment_list_screen.dart';
import 'package:technical_test_mosofty/screens/project_assignment/project_assignment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/addPerson': (context) => const AddPersonPage(),
        '/updatePerson': (context) => const UpdatePersonPage(),
        '/listPersons': (context) => PersonListPage(),
        '/addProject': (context) => const AddProjectPage(),
        '/listProjects': (context) => ProjectListPage(),
        '/assignProject': (context) => const ProjectAssignmentPage(),
        '/listProjectAssigned': (context) => ProjectAssignmentListPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Page d\'acceuil'),
        ),
        body: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addPerson');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/add-person.ico",
                        height: 50,
                      ),
                      Text('Ajouter un employé'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/updatePerson');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/update-user.png",
                        height: 50,
                      ),
                      Text('Modifier un employé'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addProject');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/new-project.png",
                        height: 50,
                      ),
                      Text('Ajouter un projet'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/listPersons');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/people.png",
                        height: 50,
                      ),
                      Text('Accéder aux employés'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/listProjects');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/project.png",
                        height: 50,
                      ),
                      Text('Accéder aux projets'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/assignProject');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/project-manager.png",
                        height: 50,
                      ),
                      Text('Affecter un projet'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/listProjectAssigned');
                },
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/project-done.png",
                        height: 50,
                      ),
                      Text('Les projets affectés'),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
