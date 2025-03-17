import 'package:flutter/material.dart';

class LiveMap extends StatelessWidget {
  const LiveMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Map')),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0), // Add left padding here
        child: Text(
          'Welcome to Live Map!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
