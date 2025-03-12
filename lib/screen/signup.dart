import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iotrafix/component/my_textfield.dart';
import 'package:iotrafix/screen/welcome.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content placed on top of background
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Row(
                children: [
                  BackButton(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Icon(
                      Icons.person_add,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 355),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Get Started',
                    style: GoogleFonts.archivoBlack(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MyTextfield(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),

                  MyTextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  MyTextfield(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  SizedBox(height: 34,),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WelcomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'SignUp',
                        style: GoogleFonts.archivoBlack(
                          fontSize: 18,
                          color: Colors.black,
                        )
                      )
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        'Or Continue With',
                        style: GoogleFonts.archivoBlack(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: 40, // set width
                    height: 40, // same as width to make it square
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10), // optional, to make rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // match container border radius
                      child: Image.asset(
                        'assets/images/google.jpg',
                        fit: BoxFit.cover, // this makes image fill the space
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


