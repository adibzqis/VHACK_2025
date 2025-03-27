import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iotrafix/dashboardScreen/Dashboard.dart';
import 'package:iotrafix/loginScreen/signin.dart';
import 'package:iotrafix/loginScreen/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/background.jpg', // Ensure this path is correct
              fit: BoxFit.cover,
            ),
          ),

          // Foreground UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // IoTraffix Title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 200.0, top: 25.0),
                    child: Column(
                      children: [
                        Text(
                          'IoTraffix',
                          style: GoogleFonts.archivoBlack(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Making Every Drive a Safe Drive',
                          style: GoogleFonts.archivoBlack(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Welcome Text
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome Back!\n',
                            style: GoogleFonts.archivoBlack(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: '\nWe have been missing you!',
                            style: GoogleFonts.archivoBlack(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Buttons Row
                  Padding(
                    padding: const EdgeInsets.only(top : 30),
                    child: Row(
                      children: [
                        // Sign In Button
                        Expanded(
                          child: buildGradientButton(
                            text: 'Sign In',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SigninScreen()),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Register Button
                        Expanded(
                          child: buildGradientButton(
                            text: 'Register',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Guest Mode Button
                  buildGradientButton(
                    text: 'Guest Mode',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardApp()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gradient Button Builder
  Widget buildGradientButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C00), Color(0xFFFFA500)], // Orange gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent, // Makes gradient visible
          shadowColor: Colors.transparent, // Avoids default button shadow
        ),
        child: Text(
          text,
          style: GoogleFonts.archivoBlack(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
