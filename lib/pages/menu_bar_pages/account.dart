import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key,});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
        'Account',
        style: TextStyle(fontSize: 25, fontFamily: 'Raritas'),
      ),
      backgroundColor: appBarColor,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
