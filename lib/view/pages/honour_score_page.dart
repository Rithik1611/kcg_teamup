import 'package:flutter/material.dart';
import 'package:kcg_teamup/model/profile_model.dart';

class HonourScorePage extends StatelessWidget {
  final HonourScore honourScore;

  HonourScorePage(this.honourScore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Honour Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(honourScore.description),
      ),
    );
  }
}
