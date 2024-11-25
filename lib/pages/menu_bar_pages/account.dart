import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 75,
                child: ClipOval(
                  child: Image.network(
                    'https://media.istockphoto.com/id/2151669184/vector/vector-flat-illustration-in-grayscale-avatar-user-profile-person-icon-gender-neutral.jpg?s=612x612&w=0&k=20&c=UEa7oHoOL30ynvmJzSCIPrwwopJdfqzBs0q69ezQoM8=',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //TODO USERNAME FROM DATABASE
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Nicki Minaj",
                    style: TextStyle(fontSize: 25, fontFamily: mainFont),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Add your edit logic here
                    },)
                ],
              ),
              Divider(),
              const SizedBox(height: 16),
              _buildComponentBox('johndoe@example.com', 0xe22a),
              const SizedBox(height: 8),
              _buildComponentBox('123-456-7890',0xe4a2),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildComponentBox(String info, int icon) {
    IconData iconData = IconData(icon, fontFamily: 'MaterialIcons');
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: boxColor,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const SizedBox(width:10,),
            Icon(iconData),
            const SizedBox(width:10,),
            Expanded(
              child: Text(
                '$info',
                style: TextStyle(fontSize: 20, fontFamily: mainFont, color: textForeground),
              ),
            ),
            if (icon != 0xe22a)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add your edit logic here
                },
              ),
          ],
        ),
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(fontSize: 25, fontFamily: mainFont),
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

