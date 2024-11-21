import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Register',
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontFamily: "Raritas"
      ),
    );
  }
}

class EmailContainer extends StatelessWidget {
  final TextEditingController controller;

  const EmailContainer({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 25, right: 25),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(13),
          hintText: 'Email',
          hintStyle: TextStyle(color: Color(0xffcecccc)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}

class PasswordContainer extends StatefulWidget {
  final TextEditingController controller;

  const PasswordContainer({required this.controller, super.key});

  @override
  _PasswordContainerState createState() => _PasswordContainerState();
}

class _PasswordContainerState extends State<PasswordContainer> {
  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscured,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(13),
          hintText: 'Password',
          hintStyle: const TextStyle(color: Color(0xffcecccc)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xffcecccc),
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}

class AltAuthRow extends StatelessWidget {
  final BuildContext context;
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;

  const AltAuthRow({
    required this.context,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onGooglePressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(0xfff5f5f4),
          ),
          child: SvgPicture.asset(
            'assets/icons/Google_logo.svg',
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(width: 20.0),
        ElevatedButton(
          onPressed: onFacebookPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(0xff3b579d),
          ),
          child: SvgPicture.asset(
            'assets/icons/Facebook_logo.svg',
            height: 50,
            width: 50,
          ),
        ),
      ],
    );
  }
}