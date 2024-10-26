import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joub_jum/pages/auth_pages/widgets.dart';

import '../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginButton() async{
    await AuthService().signin(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );  }
  void _loginWithGoogle() {
    // Add Google login functionality
  }

  void _loginWithFacebook() {
    // Add Facebook login functionality
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
          const LoginText(),
          EmailContainer(controller: _emailController),
          PasswordContainer(controller: _passwordController),
          const SizedBox(height: 20.0),
          LoginButton(onPressed: _loginButton),
          const SizedBox(height: 20.0),
          const ForgotPasswordText(),
          const SizedBox(height: 20.0),
          const Divider(),
          const SizedBox(height: 15.0),
          const Text(
            'Or Sign-in with',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 25),
          AltAuthRow(
            context: context,
            onGooglePressed: _loginWithGoogle,
            onFacebookPressed: _loginWithFacebook,
          ),
        ],
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Login',
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({required this.onPressed, super.key});

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
        'LOGIN',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Forgot password?',
      style: TextStyle(color: Colors.blue),
    );
  }
}
