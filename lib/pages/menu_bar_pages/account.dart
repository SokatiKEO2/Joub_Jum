import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import '../../auth.dart';
import '../../widgets/confirmation.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: mainAccountComponents(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Confirmation(text: "sign out", function: () async {await AuthService().signOut(context: context);});
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBarColor,
                  foregroundColor: bodyColor,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons')),
                    Text(
                      'Sign Out',
                      style: TextStyle(fontFamily: mainFont),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column mainAccountComponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          maxRadius: 60,
          backgroundColor: Colors.black,
            backgroundImage: NetworkImage("https://en.vogue.me/wp-content/uploads/2022/03/Nicki-Minaj-Barbie-diamond-necklace-Ashna-Mehta.jpg"),
        ),
        //TODO USERNAME FROM DATABASE
        const SizedBox(
          height: 16,
        ),
        buildSignOutButton(),
        const Divider(),
        const SizedBox(height: 16),
        _buildComponentBox('johndoe@example.com', 0xe22a),
        const SizedBox(height: 8),
        _buildComponentBox('123-456-7890', 0xe4a2),
        const SizedBox(height: 16),
        _buildComponentBox("Password", 0xf00f0),
      ],
    );
  }

  Row buildSignOutButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 48,
          child: Icon(Icons.verified_user),
        ),
        const Text(
          "Nicki Minaj",
          style: TextStyle(fontSize: 25, fontFamily: mainFont),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Add your edit logic here
          },
        )
      ],
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
            const SizedBox(
              width: 10,
            ),
            Icon(iconData),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                info,
                style: const TextStyle(
                    fontSize: 20, fontFamily: mainFont, color: textForeground),
              ),
            ),
            if (icon != 0xe22a)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
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
