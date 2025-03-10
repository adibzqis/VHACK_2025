import 'package:flutter/material.dart';
import 'package:iotrafix/screen/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoTraffix',
      home: const WelcomeScreen(),
    );
  }
}
