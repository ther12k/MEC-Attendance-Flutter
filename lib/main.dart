import 'package:flutter/material.dart';
import './ChooseDetailsPage/chooseDetails.dart';
import './AttendancePage/attendancepage.dart';
import './redirection.dart';
import './NotificationHandler/notifications.dart';

void main() {
  runApp(MyApp());
  setUpNotifications();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (BuildContext context) => Redirect(),
        '/choose': (BuildContext context) => ChooseDetails(),
        '/attendance': (BuildContext context) => AttendancePage(),
      },
    );
  }
}
