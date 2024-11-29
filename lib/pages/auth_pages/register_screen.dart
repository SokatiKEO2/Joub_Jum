import 'package:flutter/material.dart';
import 'package:joub_jum/auth.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/widgets/auth_widgets.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  final String username;
  final String phonenum;
  const RegisterPage({super.key, required this.username, required this.phonenum});

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
    AuthService().addUsernameAndPhoneNum(username: widget.username, phonenum:  widget.phonenum, context: context);
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
            const SizedBox(height: 20.0),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(height: 15.0),
            const AlreadyHaveAccount(),
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
          fontFamily: "Raritas",
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
          const Text("Already have an account? "),
          GestureDetector(
            onTap: () {
              navigateToNextScreen(context, const LoginPage());
            },
            child: const Text(
              "Log in",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
