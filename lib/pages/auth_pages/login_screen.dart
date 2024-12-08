import 'package:flutter/material.dart';
import 'package:joub_jum/auth.dart';
import 'package:joub_jum/pages/auth_pages/username.dart';
import 'package:joub_jum/widgets/auth_widgets.dart';

import '../../consts.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginButton() async {
    await AuthService().signin(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

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
      backgroundColor: bodyColor,
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        padding: const EdgeInsets.symmetric(horizontal: 25.0), // Optional padding for aesthetics
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            const LoginText(),
            EmailContainer(controller: _emailController),
            PasswordContainer(controller: _passwordController),
            const SizedBox(height: 20.0),
            LoginButton(onPressed: _loginButton),
            const SizedBox(height: 10.0),
            const ForgotPasswordText(),
            const Divider(),
            const SizedBox(height: 10.0),
            const dontHaveAccount(),
            const Text(
              'Or Sign-in with',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontFamily: mainFont
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
          fontFamily: mainFont
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
          backgroundColor: appBarColor,
          foregroundColor: bodyColor
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          fontFamily: "Raritas",
          fontSize: 20,
        ),
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateToNextScreen(context, ForgotPasswordPage());
      },
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Colors.blue, fontFamily: mainFont, fontSize: 18),
      ),
    );
  }
}

class dontHaveAccount extends StatelessWidget {
  const dontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? ", style: TextStyle(fontFamily: mainFont, fontSize: 18),),
          GestureDetector(
            onTap: () {
              navigateToNextScreen(context, const Username());
            },
            child: const Text(
              "Register",
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