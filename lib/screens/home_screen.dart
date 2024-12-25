import 'package:flutter/material.dart';

import 'Call_logs_screen.dart';
import 'contacts_screen.dart';
import 'dialpad_screen.dart';
import 'profile_screen.dart';
import 'reachout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Default tab index is set to 0 (Call Logs)

  // Screens for each tab
  final List<Widget> _screens = [
    CallLogScreen(),  // Call Logs screen is the first tab
    ContactsScreen(),
    DialpadScreen(),
    ReachoutScreen(),
    ProfileScreen( name: "Default Name", // Provide a default or placeholder name
    number: "000-000-0000", // Provide a default or placeholder number
    callHistory: [], ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Surefy.AI"),
        centerTitle: true,
      ),
      body: _screens[_currentIndex], // Display the current tab screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Change the tab index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call Logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dialpad),
            label: 'Dialpad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over),
            label: 'Reachout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
