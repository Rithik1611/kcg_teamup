import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String description;

  Event({required this.title, required this.description});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
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

  late Database _database;
  final StoreRef<String, List<Object?>> _store =
      StoreRef<String, List<Object?>>('events');

  @override
  void initState() {
    super.initState();
    _initDb().then((_) {
      _loadEvents();
    });
  }

  Future<void> _initDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = '${appDocDir.path}/calendar_app.db';
    _database = await databaseFactoryIo.openDatabase(dbPath);
  }

  void _loadEvents() async {
    final records = await _store.find(_database);
    Map<DateTime, List<Event>> loadedEvents = {};
    for (var record in records) {
      DateTime date = DateTime.parse(record.key);
      List<Event> events = (record.value as List)
          .map((eventJson) => Event.fromJson(eventJson as Map<String, dynamic>))
          .toList();
      loadedEvents[date] = events;
    }

    setState(() {
      _events = loadedEvents;
    });
  }

  Future<void> _saveEvents() async {
    await _store.delete(_database); // Clear the existing records

    for (var entry in _events.entries) {
      await _store.record(entry.key.toIso8601String()).put(
            _database,
            entry.value.map((e) => e.toJson() as Object?).toList(),
          );
    }
  }

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
                  _saveEvents();
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
        title: Text("Calendar"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(Icons.chevron_left_sharp),
        ),
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
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              markerDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
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
      _saveEvents();
    });
  }
}
