import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iotrafix/component/my_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Top AppBar-like section with back button and icon
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Row(
                children: [
                  BackButton(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Icon(
                      Icons.lock_reset,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.only(top: 355),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.archivoBlack(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter your email to reset your password',
                    style: GoogleFonts.archivoBlack(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Email input
                  MyTextfield(
                    controller: emailController,
                    hintText: 'Email Address',
                    obscureText: false,
                  ),

                  SizedBox(height: 30),

                  // Reset button
                  ElevatedButton(
                    onPressed: () {
                      // Add reset logic here (e.g., send reset email)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset link sent!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      'Reset Password',
                      style: GoogleFonts.archivoBlack(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Back to Sign In
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Text(
                      'Back to Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
