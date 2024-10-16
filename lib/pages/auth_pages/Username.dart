import 'package:flutter/material.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {

  void _clickedButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100.0,
          ),
          Text(
            'Username',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 25, right: 25),
            child: TextField(
              keyboardType: TextInputType.phone, // Phone keyboard
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(13),
                hintText: 'Enter username',
                hintStyle: TextStyle(
                    color: Color(0xffcecccc)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: _clickedButton,
            child: Icon(Icons.arrow_forward, color: Colors.black,),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
          )
        ],
      ),
    );
  }
}
