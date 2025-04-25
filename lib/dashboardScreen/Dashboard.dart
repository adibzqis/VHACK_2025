import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iotrafix/shoppingScreens/ShoppingScreen.dart';
import 'package:iotrafix/dashboardScreen/profile.dart';
import '../loginScreen/welcome.dart';
import 'profile.dart';
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
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF3F74FF),
        scaffoldBackgroundColor: const Color(0xFF3F74FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3F74FF),
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.archivoBlackTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  //final String username;

  DashboardScreen({
    //required this.username,
    super.key
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;

  final List<Widget> screens = [
    DashboardHomeScreen(), // Dashboard main grid
    NewsScreen(),
    Shoppingscreen(),
    ProfileUI(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 45),
      Icon(Icons.notifications, size: 45),
      Icon(Icons.shopping_cart, size: 45),
      Icon(Icons.person, size: 45),
      Icon(Icons.settings, size: 45),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF3F74FF),
      drawer: index == 0 ? _buildDrawer(context) : null, // Drawer only for Home
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(index),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: index == 0
            ? Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        )
            : null,
      ),
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: items,
        index: index,
        height: 70,
        animationCurve: Curves.easeInOut,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'News';
      case 2:
        return 'Shopping';
      case 3:
        return 'Profile';
      case 4:
        return 'Settings';
      default:
        return 'App';
    }
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Drawer Header with Profile
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3F74FF), Color(0xFF1A45D9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text(
                'Example',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('adib@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Color(0xFF3F74FF)),
              ),
            ),

            // Menu Items
            _buildDrawerItem(Icons.dashboard, 'Home', () {
              setState(() => index = 0);
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.settings, 'Settings', () {
              setState(() => index = 4);
              Navigator.pop(context);
            }),
            const Divider(), // Adds a separator line

            _buildDrawerItem(Icons.logout, 'Log Out', () {
              Navigator.pop(context);
              _showLogoutConfirmationDialog(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 28, color: const Color(0xFF3F74FF)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore your features below',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                DashboardCard(
                  title: 'Proximity Detection',
                  icon: Icons.car_crash,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveMapApp())),
                ),
                DashboardCard(
                  title: 'Traffic Light Alert',
                  icon: Icons.traffic_outlined,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SmartSignalAssistantScreen())),
                ),
                DashboardCard(
                  title: 'Hazard Report',
                  icon: Icons.dangerous,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HazardReportScreen())),
                ),
                DashboardCard(
                  title: 'News',
                  icon: Icons.newspaper,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewsScreen())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double titleFontSize; // <-- new parameter

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.titleFontSize = 20, // <-- default font size
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: const Color(0xFF3F74FF)),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize, // <-- use the new parameter here
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Log Out'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}
