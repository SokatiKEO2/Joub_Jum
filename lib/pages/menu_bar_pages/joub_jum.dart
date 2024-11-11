import 'package:flutter/material.dart';

import '../../consts.dart';

class JoubJumPage extends StatefulWidget {
  const JoubJumPage({super.key});

  @override
  State<JoubJumPage> createState() => _JoubJumPageState();
}

class _JoubJumPageState extends State<JoubJumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          children: [
            buildInvitations('User1', '03/11/24', '6:00 PM', 'Ambience Bar'),
            buildInvitations('Kati', '04/11/24', '8:00 PM', 'Hub'),
          ],
        ),
      ),
    );
  }

  Widget buildInvitations(String user, String date, String time, String location) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => _onInvitationTap(user, date, time, location),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: buttonColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'JoubJum with $user\n',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: '\nDate & Time: $date, $time\nLocation: $location',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle invitation tap
  void _onInvitationTap(String user, String date, String time, String location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on JoubJum with $user'),
      ),
    );
    // You can replace this with any function you want to call on tap.
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'JoubJum',
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFcaffbf),
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
