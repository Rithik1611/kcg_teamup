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

  void _createTeam() {
    // Logic to create a team
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Team'),
          content: Text('This is where you would create your team.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
                          : AssetImage('assets/profile_image.png') as ImageProvider,
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editYear,
                        child: Text(
                          year,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      GestureDetector(
                        onTap: _createTeam,
                        child: Text(
                          'Create your team',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: skills.map((skill) => Chip(label: Text(skill, style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue)).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _showAddSkillDialog,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Add Skill', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Interested:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: interests.map((interest) => Chip(label: Text(interest, style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue)).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _showAddInterestDialog,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Add Interest', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Reports:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
                  subtitle: Text('Rank this month: #7\nRank last month: #5\nPersonal Best: #2'),
                  onTap: _navigateToLeaderboard,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.star, color: Colors.blue),
                  title: Text('Honour Score'),
                  subtitle: Text('This Score allows people to rate you for teamwork and ethics.'),
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

// Separate pages for different reports

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leader-Board Rank'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Leader-Board Rank Details Here',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}

class HonourScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Honour Score'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Honour Score Details Here',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}

class SocialMediaHandlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Media Handles'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Social Media Handles Details Here',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}

class ProjectsJoinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects Joined'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Projects Joined Details Here',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}