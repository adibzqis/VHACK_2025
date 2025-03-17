import 'package:flutter/material.dart';
import 'package:iotrafix/loginScreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoTraffix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // or customize your theme
      home: const SplashScreen(),
    );
  }
}
