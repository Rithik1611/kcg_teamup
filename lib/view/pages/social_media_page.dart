import 'package:flutter/material.dart';
import 'package:kcg_teamup/model/profile_model.dart';

class SocialMediaPage extends StatelessWidget {
  final SocialMedia socialMedia;

  SocialMediaPage(this.socialMedia);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Media'),
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
