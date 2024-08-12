import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/add_main_screen.dart';
import 'package:kcg_teamup/view/pages/home.dart';
import 'package:kcg_teamup/view/pages/profile_page.dart';
import 'package:kcg_teamup/view/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScaffold(), // Home page
    AddMainScreen(), // Add page
    ProfilePage(), // Profile page
  ];

  void _onSearchTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamCreationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'Home Page'
            : _selectedIndex == 1
                ? 'Add Page'
                : 'Profile Page'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchTapped,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_active),
              onPressed: () {
                // Handle notifications button press
              },
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(115, 158, 158, 158),
        buttonBackgroundColor: Color.fromARGB(51, 0, 0, 0),
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _selectedIndex == 0 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: _selectedIndex == 1 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _selectedIndex == 2 ? Colors.black : Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
