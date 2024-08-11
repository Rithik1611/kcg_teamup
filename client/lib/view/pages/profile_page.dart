import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
 

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Angelica Jackson';
  String year = 'second year';
  List<String> skills = ['Java', 'Flutter', 'Node js'];
  List<String> interests = ['Fast-api', 'python'];
  File? _image;

  final ImagePicker _picker = ImagePicker();

  void _editName() {
    TextEditingController nameController = TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter your name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editYear() {
    TextEditingController yearController = TextEditingController(text: year);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Year'),
          content: TextField(
            controller: yearController,
            decoration: InputDecoration(hintText: "Enter your year"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  year = yearController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addSkill(String skill) {
    setState(() {
      skills.add(skill);
    });
  }

  void _showAddSkillDialog() {
    TextEditingController skillController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Skill'),
          content: TextField(
            controller: skillController,
            decoration: InputDecoration(hintText: "Enter a new skill"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (skillController.text.isNotEmpty) {
                  _addSkill(skillController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addInterest(String interest) {
    setState(() {
      interests.add(interest);
    });
  }

  void _showAddInterestDialog() {
    TextEditingController interestController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Interest'),
          content: TextField(
            controller: interestController,
            decoration: InputDecoration(hintText: "Enter a new interest"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (interestController.text.isNotEmpty) {
                  _addInterest(interestController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _navigateToLeaderboard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaderboardPage()),
    );
  }

  void _navigateToHonourScore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HonourScorePage()),
    );
  }

  void _navigateToSocialMediaHandles() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SocialMediaHandlesPage()),
    );
  }

  void _navigateToProjectsJoined() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProjectsJoinedPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : AssetImage('assets/profile_image.png')
                              as ImageProvider,
                      backgroundColor: Colors.blue,
                      child: _image == null
                          ? Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _editName,
                        child: Text(
                          name,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editYear,
                        child: Text(
                          year,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skill set:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: skills
                    .map((skill) => Chip(
                        label: Text(skill, style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue))
                    .toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _showAddSkillDialog,
                icon: Icon(Icons.add, color: Colors.white),
                label:
                    Text('Add Skill', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Interested:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: interests
                    .map((interest) => Chip(
                        label: Text(interest,
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue))
                    .toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _showAddInterestDialog,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Add Interest',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Reports:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.folder, color: Colors.blue),
                  title: Text('Current Projects - 2 Joined'),
                  subtitle: Text('Date joined: 04/07/24\nDate joined: 28/06/24'),
                  onTap: _navigateToProjectsJoined,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.link, color: Colors.blue),
                  title: Text('Social-Media Handles'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Portfolio url'),
                      Text('LinkedIn url'),
                      Text('GitHub url'),
                    ],
                  ),
                  onTap: _navigateToSocialMediaHandles,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.leaderboard, color: Colors.blue),
                  title: Text('Leader-Board Rank'),
                  subtitle: Text(
                      'Rank this month: #7\nRank last month: #5\nPersonal Best: #2'),
                  onTap: _navigateToLeaderboard,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.bar_chart, color: Colors.blue),
                  title: Text('Honour-Board Score'),
                  subtitle: Text(
                      'Current Score: 106\nLast Score: 98\nPersonal Best: 113'),
                  onTap: _navigateToHonourScore,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Leaderboard Model
class Student {
  final String name;
  final int projectsWon;
  final int projectsJoined;

  Student({required this.name, required this.projectsWon, required this.projectsJoined});
}

// Leaderboard Sorting Logic
List<Student> students = [
  Student(name: 'John Doe', projectsWon: 5, projectsJoined: 10),
  Student(name: 'Jane Smith', projectsWon: 7, projectsJoined: 12),
  Student(name: 'Alice Johnson', projectsWon: 5, projectsJoined: 8),
  Student(name: 'Bob Brown', projectsWon: 6, projectsJoined: 15),
];

List<Student> getSortedLeaderboard() {
  students.sort((a, b) {
    if (b.projectsWon != a.projectsWon) {
      return b.projectsWon.compareTo(a.projectsWon);
    } else {
      return b.projectsJoined.compareTo(a.projectsJoined);
    }
  });
  return students;
}

// Leaderboard Page UI
class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Student> sortedStudents = getSortedLeaderboard();

    return Scaffold(
      appBar: AppBar(
        title: Text('Leader-Board Rank'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: sortedStudents[0].projectsWon.toDouble() + 2,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.blueAccent,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String studentName = sortedStudents[group.x.toInt()].name;
                      return BarTooltipItem(
                        '$studentName\n',
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${rod.toY} Projects Won',
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          sortedStudents[value.toInt()].name.split(' ')[0],
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(sortedStudents.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: sortedStudents[index].projectsWon.toDouble(),
                        color: Colors.blue,
                        width: 20,
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortedStudents.length,
              itemBuilder: (context, index) {
                Student student = sortedStudents[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'), // Display rank
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(student.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Projects Won: ${student.projectsWon}, Projects Joined: ${student.projectsJoined}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Honour-Board Score Page (Placeholder)
class HonourScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Honour-Board Score'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Honour-Board Score Details'),
      ),
    );
  }
}

// Social-Media Handles Page (Placeholder)
class SocialMediaHandlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social-Media Handles'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Social-Media Handles Details'),
      ),
    );
  }
}

// Projects Joined Page (Placeholder)
class ProjectsJoinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects Joined'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Details of Projects Joined'),
      ),
    );
  }
}
