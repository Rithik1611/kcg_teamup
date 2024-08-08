import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

final Profile dummyProfile = Profile(
  name: 'Angelica Jackson',
  year: 'Second Year',
  skills: ['Java', 'Flutter', 'Node js', 'Fast-api', 'Python'],
  projects: [
    Project(title: 'Project A', dateJoined: '04/07/24'),
    Project(title: 'Project B', dateJoined: '28/06/24'),
  ],
  socialMedia: SocialMedia(
    portfolioUrl: 'https://portfolio.example.com',
    linkedInUrl: 'https://linkedin.com/in/example',
    gitHubUrl: 'https://github.com/example',
  ),
  leaderboard: Leaderboard(
    currentRank: 7,
    lastMonthRank: 5,
    previousMax: 3,
  ),
  honourScore: HonourScore(
    description: 'This score allows people to rate you for teamwork and ethics',
  ),
);

class Profile {
  final String name;
  final String year;
  final List<String> skills;
  final List<Project> projects;
  final SocialMedia socialMedia;
  final Leaderboard leaderboard;
  final HonourScore honourScore;

  Profile({
    required this.name,
    required this.year,
    required this.skills,
    required this.projects,
    required this.socialMedia,
    required this.leaderboard,
    required this.honourScore,
  });
}

class Project {
  final String title;
  final String dateJoined;

  Project({required this.title, required this.dateJoined});
}

class SocialMedia {
  final String portfolioUrl;
  final String linkedInUrl;
  final String gitHubUrl;

  SocialMedia({
    required this.portfolioUrl,
    required this.linkedInUrl,
    required this.gitHubUrl,
  });
}

class Leaderboard {
  final int currentRank;
  final int lastMonthRank;
  final int previousMax;

  Leaderboard({
    required this.currentRank,
    required this.lastMonthRank,
    required this.previousMax,
  });
}

class HonourScore {
  final String description;

  HonourScore({required this.description});
}

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
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
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
              _buildHeatMap(),
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

  Widget _buildHeatMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Participation:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.all(8.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      Widget text;
                      switch (value.toInt()) {
                        case 0:
                          text = Text('Aug', style: style);
                          break;
                        case 1:
                          text = Text('Sep', style: style);
                          break;
                        case 2:
                          text = Text('Oct', style: style);
                          break;
                        case 3:
                          text = Text('Nov', style: style);
                          break;
                        case 4:
                          text = Text('Dec', style: style);
                          break;
                        case 5:
                          text = Text('Jan', style: style);
                          break;
                        case 6:
                          text = Text('Feb', style: style);
                          break;
                        case 7:
                          text = Text('Mar', style: style);
                          break;
                        case 8:
                          text = Text('Apr', style: style);
                          break;
                        case 9:
                          text = Text('May', style: style);
                          break;
                        case 10:
                          text = Text('Jun', style: style);
                          break;
                        case 11:
                          text = Text('Jul', style: style);
                          break;
                        default:
                          text = Text('', style: style);
                          break;
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: text,
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 0),
                    FlSpot(2, 0),
                    FlSpot(3, 0),
                    FlSpot(4, 0),
                    FlSpot(5, 0),
                    FlSpot(6, 0),
                    FlSpot(7, 0),
                    FlSpot(8, 0),
                    FlSpot(9, 1),
                    FlSpot(10, 2),
                    FlSpot(11, 3),
                  ],
                  isCurved: false,
                  color: Colors.green,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
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

class ProjectsPage extends StatelessWidget {
  final List<Project> projects;

  const ProjectsPage(this.projects, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
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

class SocialMediaPage extends StatelessWidget {
  final SocialMedia socialMedia;

  const SocialMediaPage(this.socialMedia, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Portfolio: ${socialMedia.portfolioUrl}'),
            Text('LinkedIn: ${socialMedia.linkedInUrl}'),
            Text('GitHub: ${socialMedia.gitHubUrl}'),
          ],
        ),
      ),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  final Leaderboard leaderboard;

  const LeaderboardPage(this.leaderboard, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Rank: #${leaderboard.currentRank}'),
            Text('Last Month Rank: #${leaderboard.lastMonthRank}'),
            Text('Previous Max: #${leaderboard.previousMax}'),
          ],
        ),
      ),
    );
  }
}

class HonourScorePage extends StatelessWidget {
  final HonourScore honourScore;

  const HonourScorePage(this.honourScore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Honour Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(honourScore.description),
      ),
    );
  }
}