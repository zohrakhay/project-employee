import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:technical_test_mosofty/models/project.dart';
import 'package:technical_test_mosofty/services/project_service.dart';

class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  List<Project> projects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  Future<void> getProjects() async {
    List<Project> fetchedProjects = await ProjectService().getProjects();
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
        title: Text('Tous les projets'),
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
              Project project = projects[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.description),
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
