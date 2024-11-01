import 'package:flutter/material.dart';

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

    );
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
