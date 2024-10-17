import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/map_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _RegisterButton() {
    navigateToNextScreen(context, const MapPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x00000000),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          const Text(
            'Register',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child: const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(13),
                hintText: 'Email',
                hintStyle: TextStyle(color: Color(0xffcecccc)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
            child: const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(13),
                hintText: 'Password',
                hintStyle: TextStyle(color: Color(0xffcecccc)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: _RegisterButton,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            'Or Register with',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), // Makes the button round
                  padding: const EdgeInsets.all(10), // Padding for round button
                  backgroundColor:
                      const Color(0xfff5f5f4), // Background color of the button
                ),
                child: SvgPicture.asset(
                  'assets/icons/Google_logo.svg', // Google logo asset
                  height: 50, // Logo size
                  width: 50,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              // Facebook Sign-In Button with Logo
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), // Makes the button round
                  padding: const EdgeInsets.all(10), // Padding for round button
                  backgroundColor:
                      const Color(0xff3b579d), // Facebook color background
                ),
                child: SvgPicture.asset(
                  'assets/icons/Facebook_logo.svg', // Facebook logo asset
                  height: 50, // Logo size
                  width: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
