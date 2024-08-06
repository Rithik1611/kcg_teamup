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
