import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/home.dart';

class AddTeamPage extends StatefulWidget {
  const AddTeamPage({Key? key}) : super(key: key);

  @override
  _AddTeamPageState createState() => _AddTeamPageState();
}

class _AddTeamPageState extends State<AddTeamPage> {
  final _formKey = GlobalKey<FormState>();
  final _teamController = TextEditingController();
  final _name1Controller = TextEditingController();
  final _name2Controller = TextEditingController();

  final _name3Controller = TextEditingController();

  final _name4Controller = TextEditingController();
  @override
  void dispose() {
    _teamController.dispose();
    _name1Controller.dispose();
    _name2Controller.dispose();

    _name3Controller.dispose();

    _name4Controller.dispose();
    super.dispose();
  }

  void _addCategory() {
    if (_formKey.currentState!.validate()) {
      final newTeam = Team(teamname: _teamController.text);
      setState(() {
        Team.teamList.add(newTeam);
      });
      Navigator.pop(
          context, true); // Pass true to indicate a new category was added
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create a new team'),
        backgroundColor: const Color.fromARGB(255, 93, 93, 93),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _teamController,
                decoration: const InputDecoration(labelText: 'Team name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a team name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _name1Controller,
                decoration: const InputDecoration(labelText: 'student-1'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _name2Controller,
                decoration: const InputDecoration(labelText: 'student-2'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _name3Controller,
                decoration: const InputDecoration(labelText: 'student-3'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _name4Controller,
                decoration: const InputDecoration(labelText: 'student-4'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addCategory,
                child: const Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
