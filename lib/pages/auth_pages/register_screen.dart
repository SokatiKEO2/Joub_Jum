import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joub_jum/auth.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/auth_pages/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
  }
  void _registerWithGoogle() {
    // Add Google registration functionality
  }

  void _registerWithFacebook() {
    // Add Facebook registration functionality
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 100.0),
          const RegisterText(),
          EmailContainer(controller: _emailController),
          PasswordContainer(controller: _passwordController),
          const SizedBox(height: 20.0),
          ContinueButton(onPressed: _registerButton),
          const SizedBox(height: 20.0),
          const Divider(),
          const SizedBox(height: 15.0),
          const Text(
            'Or Register with',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
      child: const Text(
        'Continue',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}