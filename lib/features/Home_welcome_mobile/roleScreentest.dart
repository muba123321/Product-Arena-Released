import 'package:flutter/material.dart';

class RoleScreen extends StatelessWidget {
  final String role;

  RoleScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Role Details'),
      ),
      body: Center(
        child: Text(
          'You have selected the $role role',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
