import 'package:kcg_teamup/model/profile_model.dart';

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
