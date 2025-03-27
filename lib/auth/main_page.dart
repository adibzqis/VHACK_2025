import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iotrafix/dashboardScreen/Dashboard.dart';
import 'package:iotrafix/loginScreen/signin.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DashboardScreen();
            }
            else {
              return SigninScreen();
            }
          }
      ),
    );
  }
}
