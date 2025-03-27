import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iotrafix/component/my_textfield.dart';
import 'package:iotrafix/loginScreen/username.dart';
import 'package:iotrafix/loginScreen/welcome.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController(); // email instead of username
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signUpUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage("Please fill all fields.");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Passwords do not match.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showMessage("Signup Successful!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UsernameScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? "Signup failed.");
    } catch (e) {
      _showMessage("Something went wrong.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Row(
                children: [
                  const BackButton(color: Colors.white),
                  const Spacer(),
                  const Icon(Icons.person_add, size: 100, color: Colors.white),
                  const Spacer(),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 355),
            child: Center(
              child: SingleChildScrollView(
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
                      controller: emailController,
                      hintText: 'Email',
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
                    const SizedBox(height: 30),
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : ElevatedButton(
                      onPressed: signUpUser,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.archivoBlack(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 0.5, color: Colors.white)),
                        Text(
                          'Or Continue With',
                          style: GoogleFonts.archivoBlack(fontSize: 16, color: Colors.white),
                        ),
                        const Expanded(child: Divider(thickness: 0.5, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/google.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
