import 'package:flutter/material.dart';

class SmartSignalAssistantScreen extends StatefulWidget {
  const SmartSignalAssistantScreen({Key? key}) : super(key: key);

  @override
  _SmartSignalAssistantScreenState createState() => _SmartSignalAssistantScreenState();
}

class _SmartSignalAssistantScreenState extends State<SmartSignalAssistantScreen> {
  int activeLight = 0; // 0: Red, 1: Yellow, 2: Green

  void changeLight() {
    setState(() {
      activeLight = (activeLight + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Signal Assistant'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Traffic Light
          Container(
            width: 120,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLight(Colors.red, activeLight == 0),
                buildLight(Colors.yellow, activeLight == 1),
                buildLight(Colors.green, activeLight == 2),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: changeLight,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              'Change Light',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLight(Color color, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey[800],
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [BoxShadow(color: color, blurRadius: 20, spreadRadius: 2)]
            : [],
      ),
    );
  }
}
