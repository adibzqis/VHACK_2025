import 'package:flutter/material.dart';

void main() {
  runApp(MallParkingApp());
}

class MallParkingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mall Parking Simulation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ParkingSimulationPage(),
    );
  }
}

class ParkingSimulationPage extends StatefulWidget {
  @override
  _ParkingSimulationPageState createState() => _ParkingSimulationPageState();
}

class _ParkingSimulationPageState extends State<ParkingSimulationPage> {
  // Simulated parking spots (true = available, false = occupied)
  List<bool> parkingSpots = List.generate(10, (index) => true);

  // Position of the car (initially at the start of the aisle)
  Offset carPosition = Offset(150, 270);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mall Parking Simulation')),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            carPosition += details.delta;
            // Check if the car overlaps with any parking spot
            for (int i = 0; i < parkingSpots.length; i++) {
              final col = i % 5; // 5 spots per row

              // Define spot boundaries (1 row layout with aisle in the middle)
              final spotRect = Rect.fromLTWH(
                col * (MediaQuery.of(context).size.width / 5),
                i < 5 ? 100.0 : 400.0, // Top row or bottom row
                MediaQuery.of(context).size.width / 5 - 16,
                100.0,
              );

              if (spotRect.contains(carPosition)) {
                parkingSpots[i] = false;
              } else if (!spotRect.contains(carPosition) && !parkingSpots[i]) {
                parkingSpots[i] = true;
              }
            }
          });
        },
        child: Stack(
          children: [
            // Generate parking spots (single layer with aisle)
            ...List.generate(2, (row) {
              return Positioned(
                top: row == 0 ? 100.0 : 400.0, // Top or bottom row
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(5, (col) {
                    int index = row * 5 + col;
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width / 5 - 16,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: parkingSpots[index] ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          parkingSpots[index] ? 'Available' : 'Occupied',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
            // Aisle in the middle
            Positioned(
              top: 250.0, // Position the aisle space
              left: 0,
              right: 0,
              child: Container(
                height: 100.0,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    'Aisle',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Car positioned at the start of the aisle
            Positioned(
              left: carPosition.dx,
              top: carPosition.dy,
              child: Container(
                width: 50.0,
                height: 50.0,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Car',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}