import 'package:flutter/material.dart';
import 'package:kcg_teamup/model/profile_model.dart';

class LeaderboardPage extends StatelessWidget {
  final Leaderboard leaderboard;

  LeaderboardPage(this.leaderboard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
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
