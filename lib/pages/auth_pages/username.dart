import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/auth_pages/phone_num.dart';
import 'package:joub_jum/widgets/auth_widgets.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final usernameController = TextEditingController();
  String? warningMessage;
  Color borderColor = Colors.black;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    usernameController.removeListener(_onTextChanged);
    usernameController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (usernameController.text.isNotEmpty && warningMessage != null) {
      setState(() {
        warningMessage = null;
        borderColor = Colors.black;
      });
    }
  }

  void _clickedButton() {
    setState(() {
      if (usernameController.text.isEmpty) {
        warningMessage = "Please enter a username.";
        borderColor = Colors.red;
      } else {
        warningMessage = null;
        navigateToNextScreen(context, PhoneNum(username: usernameController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      resizeToAvoidBottomInset: true, // This makes the scaffold resize when the keyboard is present
      body: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          const Text(
            'Username',
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                fontFamily: mainFont),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child: TextField(
              controller: usernameController,
              keyboardType: TextInputType.text, // Text keyboard
              decoration: InputDecoration(
                filled: true,
                fillColor: bodyColor,
                contentPadding: const EdgeInsets.all(13),
                hintText: 'Enter username',
                hintStyle: const TextStyle(color: Color(0xffcecccc)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
            ),
          ),
          if (warningMessage != null) // Conditionally show the warning
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                warningMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14.0, fontFamily: mainFont),
              ),
            ),
          const SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: _clickedButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: appBarColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: bodyColor,
            ),
          ),
          buildAlreadyHaveAnAccount(context)
        ],
      ),
    );
  }
}