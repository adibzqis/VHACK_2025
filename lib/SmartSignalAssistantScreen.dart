import 'package:flutter/material.dart';

class SmartSignalAssistantScreen extends StatelessWidget {
  const SmartSignalAssistantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Signal Assistant Screen')),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0), // Add left padding here
        child: Text(
          'Welcome to Smart Signal Assistant Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
