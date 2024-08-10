import 'dart:async'; // Import to use Timer

import 'package:flutter/material.dart';

class TeamCreationScreen extends StatefulWidget {
  @override
  _TeamCreationScreenState createState() => _TeamCreationScreenState();
}

class _TeamCreationScreenState extends State<TeamCreationScreen> {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Alice',
      'role': 'Frontend Developer',
      'avatarUrl': 'https://i.pravatar.cc/150?img=1',
      'skills': 'React, JavaScript',
      'year': 'Junior'
    },
    {
      'name': 'Jerome',
      'role': 'Backend Developer',
      'avatarUrl': 'https://i.pravatar.cc/150?img=2',
      'skills': 'Node.js, Express',
      'year': 'Sophomore'
    },
    {
      'name': 'Don',
      'role': 'Fullstack Developer',
      'avatarUrl': 'https://i.pravatar.cc/150?img=3',
      'skills': 'Flutter, Dart',
      'year': 'Senior'
    },
    {
      'name': 'Raghu',
      'role': 'Data Scientist',
      'avatarUrl': 'https://i.pravatar.cc/150?img=4',
      'skills': 'Python, Machine Learning',
      'year': 'Freshman'
    },
    {
      'name': 'Jamal',
      'role': 'DevOps Engineer',
      'avatarUrl': 'https://i.pravatar.cc/150?img=5',
      'skills': 'Docker, Kubernetes',
      'year': 'Senior'
    },
  ];

  String searchQuery = '';
  String yearQuery = ''; // Additional search criterion
  final Set<int> selectedTeamMembers = {};
  Timer? debounce;

  @override
  void dispose() {
    debounce
        ?.cancel(); // Ensure the timer is canceled when the widget is disposed
    super.dispose();
  }

  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredMembers = teamMembers
        .where((member) =>
            member['skills']!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) &&
            member['year']!.toLowerCase().contains(yearQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Team creation accomplishment'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for team members by skill',
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          // Additional search field for year
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  yearQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for team members by year',
                prefixIcon: Icon(Icons.calendar_today),
                suffixIcon: yearQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            yearQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          // Display selected team members
          if (selectedTeamMembers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Selected Team Members:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: selectedTeamMembers.map((index) {
                      final member = teamMembers[index];
                      return Chip(
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(member['avatarUrl']!),
                        ),
                        label: Text(member['name']!),
                        deleteIcon: Icon(Icons.close),
                        onDeleted: () {
                          setState(() {
                            selectedTeamMembers.remove(index);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          // Show filtered team members
          if (searchQuery.isNotEmpty || yearQuery.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  final originalIndex = teamMembers.indexOf(member);
                  final isSelected =
                      selectedTeamMembers.contains(originalIndex);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member['avatarUrl']!),
                    ),
                    title: Text(member['name']!),
                    subtitle: Text(
                        '${member['role']} - ${member['skills']} (${member['year']})'),
                    trailing: IconButton(
                      icon: Icon(
                        isSelected ? Icons.check : Icons.add,
                        color: isSelected ? Colors.green : Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            selectedTeamMembers.remove(originalIndex);
                          } else {
                            selectedTeamMembers.add(originalIndex);
                          }
                        });
                      },
                    ),
                    onTap: () {
                      // Implement onTap action if needed
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
