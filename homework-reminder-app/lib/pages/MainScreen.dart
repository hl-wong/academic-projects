import 'package:flutter/material.dart';
import 'package:homework_reminder_app/notification.dart';
import 'package:homework_reminder_app/pages/Calendar.dart';
import 'package:homework_reminder_app/pages/Tasks.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _MainScreen();
  }
}

class _MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    Tasks(),
    Calendar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    NotificationHelper.checkNotificationPermissions(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task, 
              size: 24.0
            ),
            label: "Tasks"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              size: 24.0,
            ),
            label: "Calendar",
          )
        ],
      ),
    );
  }
}