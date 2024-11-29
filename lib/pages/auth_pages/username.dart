import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/auth_pages/login_screen.dart';
import 'package:joub_jum/pages/auth_pages/phone_num.dart';
import 'package:joub_jum/pages/auth_pages/register_screen.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final usernameController = TextEditingController();

  void _clickedButton() {
    navigateToNextScreen(context, PhoneNum(username: usernameController.text));
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
            'Username',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child: TextField(
              controller: usernameController,
              keyboardType: TextInputType.phone, // Phone keyboard
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(13),
                hintText: 'Enter username',
                hintStyle: TextStyle(color: Color(0xffcecccc)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: _clickedButton,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
