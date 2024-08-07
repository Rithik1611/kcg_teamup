import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/add_main_screen.dart';
import 'package:kcg_teamup/view/pages/chat_page.dart';
import 'package:kcg_teamup/view/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    if (index == 2) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddMainScreen()),
      );
      if (result == true) {
        // Update state to refresh the home page
        setState(() {
          _selectedIndex = 0;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.envelope),
            label: 'Message',
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    String title = '';
    switch (_selectedIndex) {
      case 0:
        title = 'Home Page';
        break;
      case 1:
        title = 'Search Page';
        break;
      case 2:
        title = 'Add Page';
        break;
      case 3:
        title = 'Profile Page';
        break;
      case 4:
        title = 'Message Page';
        break;
    }

    return AppBar(
      title: Text(title),
      backgroundColor: const Color.fromARGB(255, 93, 93, 93),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // Handle menu button press
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Manage();
      case 1:
        return Center(
          child: Text(
            'Selected Index: $_selectedIndex',
            style: TextStyle(fontSize: 24),
          ),
        );
      case 2:
        return AddMainScreen();
      case 3:
        return Center(
          child: Text(
            'Selected Index: $_selectedIndex',
            style: TextStyle(fontSize: 24),
          ),
        );
      case 4:
        return ChatPage();
      default:
        return Center(
          child: Text(
            'Selected Index: $_selectedIndex',
            style: TextStyle(fontSize: 24),
          ),
        );
    }
  }
}
