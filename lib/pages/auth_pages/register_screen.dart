import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joub_jum/auth.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/widgets/auth_widgets.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  final String username;
  final String phonenum;

  const RegisterPage(
      {super.key, required this.username, required this.phonenum});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _registerButton() async {
    await AuthService().signup(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
    addUsernameAndPhoneNum(
        email: _emailController.text,
        username: widget.username,
        phonenum: widget.phonenum,
        context: context);
  }

  void _registerWithGoogle() {
    // Add Google registration functionality
  }

  void _registerWithFacebook() {
    // Add Facebook registration functionality
  }

  Future<void> addUsernameAndPhoneNum({
    required String username,
    required String phonenum,
    required String email,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'username': username,
          'phonenum': phonenum,
          'email': email,
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No authenticated user found.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user details: $e')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: bodyColor,
      body: SingleChildScrollView( // Wrap the body in a SingleChildScrollView
        padding: const EdgeInsets.symmetric(horizontal: 25.0), // Padding for better layout
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            const RegisterText(),
            EmailContainer(controller: _emailController),
            PasswordContainer(controller: _passwordController),
            const SizedBox(height: 20.0),
            ContinueButton(onPressed: _registerButton),
            const SizedBox(height: 34.0),
            const Divider(),
            const SizedBox(height: 15.0),
            const AlreadyHaveAccount(),
            const Text(
              'Or Register with',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontFamily: mainFont
              ),
            ),
            const SizedBox(height: 25),
            AltAuthRow(
              context: context,
              onGooglePressed: _registerWithGoogle,
              onFacebookPressed: _registerWithFacebook,
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: appBarColor,
        foregroundColor: bodyColor,
      ),
      child: const Text(
        'Continue',
        style: TextStyle(
          fontFamily: mainFont,
          fontSize: 20,
        ),
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account? ",style: TextStyle(fontFamily: mainFont, fontSize: 18),),
          GestureDetector(
            onTap: () {
              navigateToNextScreen(context, const LoginPage());
            },
            child: const Text(
              "Log in",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: mainFont,
                  fontSize: 18
              ),
            ),
          ),
        ],
      ),
    );
  }
}
