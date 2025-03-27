import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(LiveMapApp());
}

class LiveMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Map Simulation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LiveMapPage(),
    );
  }
}

class LiveMapPage extends StatefulWidget {
  @override
  _LiveMapPageState createState() => _LiveMapPageState();
}

class _LiveMapPageState extends State<LiveMapPage> {
  Offset carPosition = Offset(150, 470);
  Offset otherCar1Position = Offset(300, 375);
  Offset otherCar2Position = Offset(200, 100);
  bool showWarning = false;
  bool showCollisionWarning = false;
  double carSpeed = 0.0;
  Offset lastPosition = Offset(150, 270);

  late Timer _carTimer;
  late Timer _trafficLightTimer;

  // Traffic light states
  String horizontalLightState = 'red';
  String verticalLightState = 'green';

  // Countdown timer for traffic lights
  int trafficLightCountdown = 5;

  @override
  void initState() {
    super.initState();

    // Timer for cars' movement
    _carTimer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      setState(() {
        // Move other cars
        otherCar1Position = Offset(otherCar1Position.dx - 3, otherCar1Position.dy);
        otherCar2Position = Offset(otherCar2Position.dx, otherCar2Position.dy + 3);

        // Wrap around screen boundaries
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        if (otherCar1Position.dx < 0) {
          otherCar1Position = Offset(screenWidth, otherCar1Position.dy);
        }
        if (otherCar2Position.dy > screenHeight) {
          otherCar2Position = Offset(otherCar2Position.dx, 0);
        }

        // Check collision with other cars
        if (_checkCollision(carPosition, otherCar1Position) ||
            _checkCollision(carPosition, otherCar2Position)) {
          showCollisionWarning = true;
        } else {
          showCollisionWarning = false;
        }

        // Calculate car speed
        double distance = _calculateDistance(lastPosition, carPosition);
        double pixelsPerSecond = distance * 2; // Convert to pixels per second
        double metersPerSecond = pixelsPerSecond * 0.20; // Assuming 1 pixel = 0.05 meters
        carSpeed = metersPerSecond * 3.6; // Convert to km/h
        lastPosition = carPosition;
      });
    });

    // Timer for traffic light state change
    _trafficLightTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        trafficLightCountdown -= 1;

        if (trafficLightCountdown == 0) {
          // Reset the countdown based on the current light state
          trafficLightCountdown = (horizontalLightState == 'red')
              ? 9
              : (horizontalLightState == 'green')
              ? 10
              : 10;

          // Cycle the horizontal and vertical lights
          if (horizontalLightState == 'red') {
            horizontalLightState = 'green';
            verticalLightState = 'red';
          } else if (horizontalLightState == 'green') {
            horizontalLightState = 'yellow';
          } else {
            horizontalLightState = 'red';
            verticalLightState = 'green';
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _carTimer.cancel();
    _trafficLightTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Map Simulation')),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            Offset newPosition = carPosition + details.delta;

            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;

            // Define boundaries for car movement
            if (newPosition.dx >= 0 &&
                newPosition.dx <= screenWidth - 30 &&
                newPosition.dy >= 0 &&
                newPosition.dy <= screenHeight - 30) {
              carPosition = newPosition;

              // Check if car is off the road
              if (!_isOnRoad(carPosition)) {
                showWarning = true;
              } else {
                showWarning = false;
              }
            }
          });
        },
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              painter: MapPainter(horizontalLightState, verticalLightState),
            ),
            Positioned(
              left: carPosition.dx,
              top: carPosition.dy,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.directions_car, color: Colors.black, size: 10),
              ),
            ),
            Positioned(
              left: otherCar1Position.dx,
              top: otherCar1Position.dy,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.directions_car, color: Colors.white, size: 10),
              ),
            ),
            Positioned(
              left: otherCar2Position.dx,
              top: otherCar2Position.dy,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.directions_car, color: Colors.white, size: 10),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Text(
                  'Speed: ${carSpeed.toStringAsFixed(1)} km/h',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 30,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Light change in: $trafficLightCountdown s',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            if (showWarning)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                left: MediaQuery.of(context).size.width / 2 - 150,
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '⚠️ WARNING: Stay on the road! ⚠️',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (showCollisionWarning)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                left: MediaQuery.of(context).size.width / 2 - 150,
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '⚠️ WARNING: Risk of collision! ⚠️',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _isOnRoad(Offset position) {
    // Define road boundaries
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Rect horizontalRoad = Rect.fromLTWH(0, screenHeight * 0.38, screenWidth, 35);
    Rect verticalRoad = Rect.fromLTWH(screenWidth * 0.38, 0, 35, screenHeight);

    bool isOnHorizontalRoad = horizontalRoad.inflate(15).contains(position);
    bool isOnVerticalRoad = verticalRoad.inflate(15).contains(position);

    return isOnHorizontalRoad || isOnVerticalRoad;
  }


  bool _checkCollision(Offset car1, Offset car2) {
    double distance = _calculateDistance(car1, car2);
    return distance < 40;
  }

  double _calculateDistance(Offset point1, Offset point2) {
    return sqrt(pow(point1.dx - point2.dx, 2) + pow(point1.dy - point2.dy, 2));
  }
}

class MapPainter extends CustomPainter {
  final String horizontalLightState;
  final String verticalLightState;

  MapPainter(this.horizontalLightState, this.verticalLightState);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint roadPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3;

    final Paint redLightPaint = Paint()..color = Colors.red;
    final Paint yellowLightPaint = Paint()..color = Colors.yellow;
    final Paint greenLightPaint = Paint()..color = Colors.green;

    // Draw roads
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.4, size.width, 90), roadPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, 0, 90, size.height), roadPaint);

    // Draw road lines
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, size.height * 0.45), Offset(i + 20, size.height * 0.45), linePaint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(size.width * 0.45, i), Offset(size.width * 0.45, i + 20), linePaint);
    }

    // Draw horizontal traffic light
    Offset horizontalLightPosition = Offset(270, 430);
    canvas.drawRect(
        Rect.fromLTWH(250, horizontalLightPosition.dy-20, 60, 40), roadPaint);
    Paint horizontalLightPaint;
    if (horizontalLightState == 'red') {
      horizontalLightPaint = redLightPaint;
    } else if (horizontalLightState == 'yellow') {
      horizontalLightPaint = yellowLightPaint;
    } else {
      horizontalLightPaint = greenLightPaint;
    }
    canvas.drawCircle(horizontalLightPosition, 15, horizontalLightPaint);

    // Draw vertical traffic light
    Offset verticalLightPosition = Offset(size.width * 0.45 +80, 280);
    canvas.drawRect(
        Rect.fromLTWH(245, verticalLightPosition.dy-40, 40, 60), roadPaint);
    Paint verticalLightPaint;
    if (verticalLightState == 'red') {
      verticalLightPaint = redLightPaint;
    } else if (verticalLightState == 'yellow') {
      verticalLightPaint = yellowLightPaint;
    } else {
      verticalLightPaint = greenLightPaint;
    }
    canvas.drawCircle(verticalLightPosition, 15, verticalLightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
