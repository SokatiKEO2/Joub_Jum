import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/widgets/auth_widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

final TextEditingController _emailController = TextEditingController();

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: bodyColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 150.0),
            const Text(
              "Enter your Email and we will send you a password reset link",
              style: TextStyle(fontSize: 25, fontFamily: "Raritas"),
            ),
            EmailContainer(controller: _emailController),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                passwordReset();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: appBarColor, foregroundColor: bodyColor),
              child: const Text(
                "Reset Password",
                style: TextStyle(fontSize: 20, fontFamily: "Raritas"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      String message = "Password reset link sent! Check your email";
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: appBarColor,
          textColor: bodyColor,
          fontSize: 18.0);
    } on FirebaseAuthException catch (e) {
      String message = e.message.toString();
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: appBarColor,
        textColor: bodyColor,
        fontSize: 18.0,
      );
    }
  }
}
