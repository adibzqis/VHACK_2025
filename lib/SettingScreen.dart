import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0), // Add left padding here
        child: Text(
          'Welcome to Settings!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}