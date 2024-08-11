import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcg_teamup/view/pages/event_details_page.dart';
import 'package:kcg_teamup/view/widgets/calender.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Colors.white),
            height: 70,
            child: Text(
              "Projects Signed",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
          child: Container(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: Team.teamList.map((team) {
                return TeamBox(name: team.teamname);
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
          child: InkWell(
            child: Calender(),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalenderTheme(),
                  ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              "Upcoming Events",
              style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
          child: Container(
            child: Home(), // Home widget will dynamically size itself
          ),
        ),
      ],
    );
  }
}

class TeamBox extends StatelessWidget {
  const TeamBox({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: Text(
            name,
            style: GoogleFonts.roboto(
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        height: 130,
        width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }
}

class Team {
  static List<Team> teamList = [
    Team(teamname: "Team desperado"),
    Team(teamname: "Team ignite"),
    Team(teamname: "Team optics"),
    Team(teamname: "Team connect"), Team(teamname: "Team desperado"),
    Team(teamname: "Team ignite"),
    Team(teamname: "Team optics"),
    Team(teamname: "Team connect"),
    // Add more teams as needed
  ];

  final String teamname;

  Team({
    required this.teamname,
  });
}

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      height: 100,
      child: Row(
        children: [
          SizedBox(width: 20),
          Icon(Icons.calendar_month_rounded, size: 35),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22),
              Text(
                "Calender",
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
              ),
              Text(
                "Plan Your Events!",
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_right_sharp, size: 40),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class CalenderTheme extends StatelessWidget {
  const CalenderTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: const CalendarPage(),
    );
  }
}

class Category {
  final String title;
  final String eventType;
  final String courseLink;
  final String about;
  final DateTime? date; // Optional 'about' field

  Category({
    required this.title,
    required this.courseLink,
    this.date,
    required this.about,
    required this.eventType,
  });

  static List<Category> popularCourseList = [];
}

class Home extends StatelessWidget {
  const Home({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  List<Category> getFilteredCategories() {
    final today = DateTime.now().toLocal();
    return Category.popularCourseList.where((category) {
      if (category.date == null) return true; // Keep categories with no date
      return category.date!.isAfter(today.subtract(const Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final filteredCategories = getFilteredCategories();
            if (filteredCategories.isEmpty) {
              // Show message if no events are available
              return const Center(
                child: Text(
                  'No upcoming events displayed',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            } else {
              // Show GridView if there are events
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Change this to 2 for 2 columns
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio:
                      1.0, // Adjust this ratio based on desired item size
                ),
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return CategoryView(
                    callback: callBack,
                    category: category,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.category,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(category: category),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurple, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SafeArea(
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
