import 'package:flutter/material.dart';
import 'package:kcg_teamup/model/dummy_data.dart';
import 'package:kcg_teamup/model/profile_model.dart';
import 'package:kcg_teamup/view/pages/honour_score_page.dart';
import 'package:kcg_teamup/view/pages/leaderboard_page.dart';
import 'package:kcg_teamup/view/pages/projects_page.dart';
import 'package:kcg_teamup/view/pages/social_media_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _skillController = TextEditingController();

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
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with actual image URL
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyProfile.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dummyProfile.year,
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Create your team'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildSkillSet(dummyProfile.skills),
              SizedBox(height: 20),
              _buildReportsSection(dummyProfile),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSkillDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSkillSet(List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skill set:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: skills.map((skill) => _buildSkillChip(skill)).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
    );
  }

  void _showAddSkillDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Skill'),
          content: TextField(
            controller: _skillController,
            decoration: InputDecoration(hintText: 'Enter skill'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  dummyProfile.skills.add(_skillController.text);
                });
                _skillController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _skillController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportsSection(Profile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Reports:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildReportItem(
          Icons.assignment,
          'Current Projects - ${profile.projects.length} Joined',
          profile.projects
              .map((p) => 'Date joined: ${p.dateJoined}')
              .join('\n'),
          () {
            // Navigate to Current Projects page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProjectsPage(profile.projects)));
          },
        ),
        _buildReportItem(
          Icons.link,
          'Social-Media Handles',
          '- ${profile.socialMedia.portfolioUrl}\n- ${profile.socialMedia.linkedInUrl}\n- ${profile.socialMedia.gitHubUrl}',
          () {
            // Navigate to Social Media Handles page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SocialMediaPage(profile.socialMedia)));
          },
        ),
        _buildReportItem(
          Icons.leaderboard,
          'Leader-Board Rank',
          'Rank this month: #${profile.leaderboard.currentRank}\nRank last month: #${profile.leaderboard.lastMonthRank}\nPrevious max: #${profile.leaderboard.previousMax}',
          () {
            // Navigate to Leader-Board Rank page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LeaderboardPage(profile.leaderboard)));
          },
        ),
        _buildReportItem(
          Icons.star,
          'Honour Score',
          profile.honourScore.description,
          () {
            // Navigate to Honour Score page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HonourScorePage(profile.honourScore)));
          },
        ),
      ],
    );
  }

  Widget _buildReportItem(
      IconData icon, String title, String description, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, size: 40),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
