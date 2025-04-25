import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import the Timer package

void main() {
  runApp(LiveMapApp());
}

class LiveMapApp extends StatefulWidget {
  @override
  _DistancePageState createState() => _DistancePageState();
}

class _DistancePageState extends State<LiveMapApp> {
  String distance = "Loading data...";
  Timer? _timer;

  // Function to fetch the latest distance data
  Future<void> fetchDistance() async {
    try {
      final response = await http.get(Uri.parse('http://10.18.71.184:5000/'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // Modify the distance by multiplying by 10 and format it to 2 decimal places
          double originalDistance = double.tryParse(data['distance'].toString()) ?? 0;
          distance = (originalDistance * 10).toStringAsFixed(2) + " cm"; // Scale the distance by 10 and format
        });
      } else {
        setState(() {
          distance = "Failed to load data: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        distance = "Error: ${e.toString()}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Start auto-refresh every 0.1 second
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      fetchDistance();
    });
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is destroyed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the text color based on the distance value
    Color textColor = double.tryParse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) != null &&
        double.parse(distance.replaceAll(RegExp(r'[^0-9.]'), '')) < 100
        ? Colors.red
        : Colors.green;

    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Light background for the app
      appBar: AppBar(
        title: Text('Near Distance', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Padding around the content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                distance,
                style: TextStyle(
                  fontSize: 48, // Larger font size for the distance
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (textColor == Colors.red)
                Icon(Icons.warning, color: Colors.red, size: 50), // Show warning icon if the distance is below threshold
            ],
          ),
        ),
      ),
    );
  }
}
