import 'package:flutter/material.dart';

class RecentLessonsScreen extends StatelessWidget {
  const RecentLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("Recent Lessons"),
        ),
      ),
    );
  }
}
