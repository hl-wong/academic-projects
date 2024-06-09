import 'package:flutter/material.dart';
import 'package:homework_reminder_app/notification.dart';
import 'package:homework_reminder_app/pages/HomePage.dart';
import 'package:homework_reminder_app/pages/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color(0xFF5D557D);

    return MaterialApp(
      title: 'Homework Reminder App',
      home: HomePage(),
    );
  }
}