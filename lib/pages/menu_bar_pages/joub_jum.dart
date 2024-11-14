import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';

class JoubJumPage extends StatefulWidget {
  const JoubJumPage({super.key});

  @override
  State<JoubJumPage> createState() => _JoubJumPageState();
}

class _JoubJumPageState extends State<JoubJumPage> {
  // List to store invitation details
  final List<Map<String, String>> _joubjums = [
    {
      "user": "Chamroeun",
      "date": "03/11/24",
      "time": "6:00 PM",
      "location": "Ambience Bar",
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "user": "Kati",
      "date": "04/11/24",
      "time": "8:00 PM",
      "location": "Hub",
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              itemCount: _joubjums.length,
              itemBuilder: (BuildContext context, int index) {
                return buildJoubJumCard(_joubjums[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildJoubJumCard(Map<String, String> joubjum) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: GestureDetector(
          onTap: () => _onInvitationTap(joubjum['user']!),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: buttonColor,
            ),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.network(
                                joubjum['imagePath']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0,),
                          Expanded(
                            child: Text(
                              'JoubJum with ${joubjum['user']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0), // Space between title and details
                      Text(
                        'Date & Time: ${joubjum['date']}, ${joubjum['time']}\nLocation: ${joubjum['location']}',
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
      ),
    );
  }

  void _onInvitationTap(String user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on JoubJum with $user'),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'JoubJums',
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
