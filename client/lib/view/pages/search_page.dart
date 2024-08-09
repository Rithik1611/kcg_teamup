import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'student_model.dart';

class TeamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 175, 175, 175),
        hintColor: const Color.fromARGB(255, 120, 120, 120),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 62, 62, 62)),
          titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black54),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
      ),
      home: TeamPage(),
    );
  }
}

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  List<Student> allStudents = [];
  List<Student> filteredStudents = [];
  String selectedSort = 'Name';

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final studentsData = prefs.getString('studentsData');
    if (studentsData != null) {
      final List<dynamic> decodedData = json.decode(studentsData);
      setState(() {
        allStudents = decodedData.map((json) => Student.fromJson(json)).toList();
        filteredStudents = allStudents;
      });
    } else {
      allStudents = [
        Student(name: 'Alice', year: 'Sophomore', skills: ['JavaScript', 'Flutter']),
        Student(name: 'Jerome', year: 'Senior', skills: ['Python', 'Django']),
        Student(name: 'Don', year: 'Junior', skills: ['Java', 'Spring']),
        Student(name: 'Raghu', year: 'Senior', skills: ['Kotlin', 'Android']),
        Student(name: 'Jamal', year: 'Freshman', skills: ['HTML', 'CSS', 'JavaScript']),
      ];
      filteredStudents = allStudents;
      saveStudents();
    }
  }

  Future<void> saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(allStudents.map((student) => student.toJson()).toList());
    prefs.setString('studentsData', encodedData);
  }

  void filterStudents(String query) {
    final filtered = allStudents.where((student) {
      return student.skills.any((skill) => skill.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    setState(() {
      filteredStudents = filtered;
      sortStudents(selectedSort); // Apply sorting after filtering
    });
  }

  void sortStudents(String criteria) {
    switch (criteria) {
      case 'Name':
        filteredStudents.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Year':
        filteredStudents.sort((a, b) => a.year.compareTo(b.year));
        break;
      case 'Number of Skills':
        filteredStudents.sort((a, b) => b.skills.length.compareTo(a.skills.length));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Creation Accomplishment', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                onChanged: filterStudents,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 0, 0, 0)),
                  hintText: 'Search for team members by skill',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Sorting Dropdown
            DropdownButton<String>(
              value: selectedSort,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedSort = newValue;
                    sortStudents(selectedSort);
                  });
                }
              },
              items: <String>['Name', 'Year', 'Number of Skills']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // List of Team Members
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 186, 186, 186),
                        child: Text(
                          filteredStudents[index].name[0],
                          style: TextStyle(color: Colors.white),
                        ),
                        radius: 25,
                      ),
                      title: Text(
                        filteredStudents[index].name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        '${filteredStudents[index].year}, Skills: ${filteredStudents[index].skills.join(', ')}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}