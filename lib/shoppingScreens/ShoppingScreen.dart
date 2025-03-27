import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iotrafix/component/itemList.dart';
import 'package:iotrafix/shoppingScreens/payment_screen.dart';

class Shoppingscreen extends StatelessWidget {
  const Shoppingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.archivoBlackTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ShoppingUI(),
    );
  }
}

class ShoppingUI extends StatelessWidget {
  const ShoppingUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 60),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Itemlist(
                  title: 'Movement Sensor',
                  subtitle: 'Detects movement on the road!',
                  icon: Icons.directions_walk,
                ),
                SizedBox(height: 20),
                Itemlist(
                  title: 'Traffic Light Assist',
                  subtitle: 'Helps you stay alert!',
                  icon: Icons.traffic,
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ItemListBoth(
                title1: 'BOTH',
                subtitle1: 'Ensures your safety on the road!',
                icon1: Icons.security,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemListBoth extends StatelessWidget {
  final String title1;
  final String subtitle1;
  final IconData icon1;

  const ItemListBoth({
    super.key,
    required this.title1,
    required this.subtitle1,
    required this.icon1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 200,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon1, size: 50, color: Colors.blueAccent),
          SizedBox(height: 15),
          Text(
            title1,
            textAlign: TextAlign.center,
            style: GoogleFonts.archivoBlack(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            subtitle1,
            textAlign: TextAlign.center,
            style: GoogleFonts.archivoBlack(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentScreen()),
              );
            },
            child: Text(
              'BUY',
              style: GoogleFonts.archivoBlack(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
