import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Category {
  String title;
  DateTime date;
  String description;
  String courseLink;

  Category({
    required this.title,
    required this.date,
    required this.description,
    required this.courseLink,
  });

  static List<Category> popularCourseList = [
    Category(
      title: 'Course 1',
      date: DateTime.now(),
      description: 'Description 1',
      courseLink: 'https://example.com/course1',
    ),
    // Add more categories as needed
  ];
}

class Home extends StatefulWidget {
  const Home({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              itemCount: Category.popularCourseList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 8.0, // Reduced horizontal spacing
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final category = Category.popularCourseList[index];
                final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Interval(
                      (1 / Category.popularCourseList.length) * index,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                );
                animationController.forward();
                return CategoryView(
                  callback: widget.callBack,
                  category: category,
                  animation: animation,
                  animationController: animationController,
                );
              },
            );
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
    required this.animationController,
    required this.animation,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;
  final Category category;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                height: 280,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                category.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                category.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse(category.courseLink);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: const Text(
                                  'Course Link',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeTeam extends StatefulWidget {
  const HomeTeam({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _HomeTeamState createState() => _HomeTeamState();
}

class _HomeTeamState extends State<HomeTeam> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: Team.teamList.length,
              itemBuilder: (context, index) {
                final team = Team.teamList[index];
                final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Interval(
                      (1 / Team.teamList.length) * index,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                );
                animationController.forward();
                return TeamView(
                  callback: widget.callBack,
                  team: team,
                  animation: animation,
                  animationController: animationController,
                  title: team.teamname, // Pass the teamname as title
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TeamView extends StatelessWidget {
  const TeamView({
    Key? key,
    required this.team,
    required this.animationController,
    required this.animation,
    this.callback,
    required this.title, // Add title parameter
  }) : super(key: key);

  final VoidCallback? callback;
  final Team team;
  final AnimationController animationController;
  final Animation<double> animation;
  final String title; // Add title variable

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                height: 10,
                width: 160, // Adjust width as needed
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title, // Display the title
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20, // Adjust fontSize as needed
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                team.name1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                team.name2,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                team.name3,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                team.name4,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Team {
  static List<Team> teamList = [
    Team(
        name1: "name1",
        name2: "name2",
        name3: "name3",
        name4: "name4",
        teamname: "teamname"),
    Team(
        name1: "name1",
        name2: "name2",
        name3: "name3",
        name4: "name4",
        teamname: "teamname"),
    Team(
        name1: "name1",
        name2: "name2",
        name3: "name3",
        name4: "name4",
        teamname: "teamname"),
    Team(
        name1: "name1",
        name2: "name2",
        name3: "name3",
        name4: "name4",
        teamname: "teamname"),
  ]; // Dummy list
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final String teamname; // Added teamname field

  Team({
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.teamname,
  });
}

class Manage extends StatefulWidget {
  const Manage({super.key});

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: HomeTeam()),
        SizedBox(
          height: 16,
        ),
        Expanded(child: Home())
      ],
    );
  }
}
