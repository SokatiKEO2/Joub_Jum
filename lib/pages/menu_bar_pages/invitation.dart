import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          children: [
            buildInvitations('User1'),
            buildInvitations('Kati'),
          ],
        ),
      ),
    );
  }

  Widget buildInvitations(String user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => _onInvitationTap(user),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: buttonColor,
          ),
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$user sent an invitation',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              buildButtons(user),
            ],
          ),
        ),
      ),
    );
  }

  Row buildButtons(String user) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Keeps the button Row compact
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onRejectPressed(user),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'X',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onAcceptPressed(user),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: Colors.green,
            ),
            child: const Text(
              '✓',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Handle container tap
  void _onInvitationTap(String user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on invitation from $user'),
      ),
    );
    // Additional logic for tapping the container can go here
  }

  // Handle "Reject" button press
  void _onRejectPressed(String user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invitation from $user rejected'),
      ),
    );
    // Additional logic for rejecting an invitation can go here
  }

  // Handle "Accept" button press
  void _onAcceptPressed(String user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invitation from $user accepted'),
      ),
    );
    // Additional logic for accepting an invitation can go here
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Invitations',
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
