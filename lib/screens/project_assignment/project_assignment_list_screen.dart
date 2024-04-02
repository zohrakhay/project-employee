import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:technical_test_mosofty/models/project_assignment.dart';
import 'package:technical_test_mosofty/services/project_service.dart';

class ProjectAssignmentListPage extends StatefulWidget {
  @override
  _ProjectAssignmentListPageState createState() => _ProjectAssignmentListPageState();
}

class _ProjectAssignmentListPageState extends State<ProjectAssignmentListPage> {
  List<ProjectAssignment> projects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  Future<void> getProjects() async {
    List<ProjectAssignment> fetchedProjects = await ProjectService().getProjectsDone();
    setState(() {
      projects = fetchedProjects;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Les projets affectés'),
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballSpinFadeLoader,
                      colors: [Colors.grey],
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Container(),
          ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              ProjectAssignment project = projects[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(project.project.name),
                    subtitle: Text('Affecté à ' + project.person.userName),
                  ),
                  Divider()
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
