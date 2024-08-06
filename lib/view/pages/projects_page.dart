import 'package:flutter/material.dart';
import 'package:kcg_teamup/model/profile_model.dart';

class ProjectsPage extends StatelessWidget {
  final List<Project> projects;

  ProjectsPage(this.projects);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return ListTile(
            title: Text(project.title),
            subtitle: Text('Date Joined: ${project.dateJoined}'),
          );
        },
      ),
    );
  }
}
