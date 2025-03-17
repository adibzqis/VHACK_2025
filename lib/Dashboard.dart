import 'package:flutter/material.dart';
import 'LiveMap.dart';
import 'SmartSignalAssistantScreen.dart';
import 'HazardReportScreen.dart';
import 'NewsScreen.dart';
import 'SettingScreen.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF3F74FF),
        scaffoldBackgroundColor: const Color(0xFF3F74FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3F74FF),
          foregroundColor: Colors.white,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F74FF),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF3F74FF)),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              _buildDrawerItem(Icons.dashboard, 'Dashboard', () {Navigator.pop(context);},),
              _buildDrawerItem(Icons.settings, 'Settings', () {Navigator.pop(context);Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));},),
              _buildDrawerItem(Icons.settings, 'Log Out', () {Navigator.pop(context);},) //will be connected to adib's screen
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
    Column(
    children: [
    Image.asset('assets/background.jpg', height: 200), // Image added here
    const SizedBox(height: 16),
    Expanded(
    child:
    GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            DashboardCard(title: 'Live Map Screen', icon: Icons.map_sharp, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LiveMap()),),),
            DashboardCard(title: 'Smart Signal Assistant Screen', icon: Icons.computer_outlined, onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartSignalAssistantScreen()),),),
            DashboardCard(title: 'Hazard Report Screen', icon: Icons.dangerous, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HazardReportScreen()),),),
            DashboardCard(title: 'News Screen', icon: Icons.newspaper, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsScreen()),),),
          ],
        ),
      ),
    ],
    ),),);
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 32, color: const Color(0xFF3F74FF)),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _navigateTo(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceholderScreen(title: title),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: const Color(0xFF3F74FF)),
              const SizedBox(height: 8),
              Text(
                title,textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder screen that will be shown when a card is clicked
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'This is the $title screen',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
