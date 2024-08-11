import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcg_teamup/view/pages/event_details_page.dart';
import 'package:kcg_teamup/view/pages/home_page.dart';
import 'package:table_calendar/table_calendar.dart';

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

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Event>> _events = {};

  void _addEventDialog(DateTime selectedDay) {
    final TextEditingController _eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: _eventController,
          decoration: const InputDecoration(hintText: 'Enter task description'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (_eventController.text.isNotEmpty) {
                  if (!_events.containsKey(selectedDay)) {
                    _events[selectedDay] = [];
                  }
                  _events[selectedDay]!.add(
                    Event(
                      title: 'Task ${_events[selectedDay]!.length + 1}',
                      description: _eventController.text,
                    ),
                  );
                }
              });
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calender"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.chevron_left_sharp)),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2050),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => _selectedDay == day,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) => _events[day] ?? [],
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Colors.blue, // Background color for selected date
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(
                    0.3), // Background color for today with opacity
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0), // Marker color in calendar
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false, // Hides the "2 weeks" button
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _addEventDialog(_selectedDay),
            child: const Text('Add Task'),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child:
                _events[_selectedDay] == null || _events[_selectedDay]!.isEmpty
                    ? const Center(child: Text('No Tasks for this day.'))
                    : ListView.builder(
                        itemCount: _events[_selectedDay]!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_events[_selectedDay]![index].title),
                            subtitle:
                                Text(_events[_selectedDay]![index].description),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteEvent(_selectedDay, index);
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(DateTime selectedDay, int index) {
    setState(() {
      _events[selectedDay]!.removeAt(index);
      if (_events[selectedDay]!.isEmpty) {
        _events.remove(selectedDay);
      }
    });
  }
}

class Event {
  final String title;
  final String description;

  Event({required this.title, required this.description});

  @override
  String toString() => '$title: $description';
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
