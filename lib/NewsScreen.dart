import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Screen')),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0), // Add left padding here
        child: Text(
          'Welcome to News Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}