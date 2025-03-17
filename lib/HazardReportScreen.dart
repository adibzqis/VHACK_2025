import 'package:flutter/material.dart';

class HazardReportScreen extends StatelessWidget {
  const HazardReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hazard Report Screen')),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0), // Add left padding here
        child: Text(
          'Welcome to Hazard Report Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}