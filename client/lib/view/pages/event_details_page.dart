import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:kcg_teamup/view/pages/home.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class EventDetailsPage extends StatelessWidget {
  final Category category;

  const EventDetailsPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' ${category.title}',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (category.title.isNotEmpty)
                        Text(
                          'Event Type: ${category.eventType}', // Assuming the 'title' field is being used for 'Event Type'
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      if (category.date != null)
                        Text(
                          'Date: ${formatDateWithoutTrailingZeros(category.date!)}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "About:",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '${category.about}',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Register at",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () => _launchURL(category.courseLink),
                        child: Text(
                          '${category.courseLink}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors
                                  .blue, // Optional: Change text color to blue for visual cue
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateWithoutTrailingZeros(DateTime date) {
    final formatter = DateFormat.yMd();
    String formattedDate = formatter.format(date);
    String day = formattedDate.split('/')[1];
    if (day.startsWith('0')) {
      day = day.substring(1);
    }
    return formattedDate.replaceFirst('/$day/', '/${day}/');
  }

  // Function to launch URL in web browser
  void _launchURL(String url) async {
    print('Launching URL: $url');
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
