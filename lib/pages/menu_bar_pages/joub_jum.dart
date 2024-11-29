import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/menu_bar_pages/joub_jum_details.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';

class JoubJumPage extends StatefulWidget {
  const JoubJumPage({super.key});

  @override
  State<JoubJumPage> createState() => _JoubJumPageState();
}

class _JoubJumPageState extends State<JoubJumPage> {

  @override
  Widget build(BuildContext context) {
    final invitationAndJoubJumState = Provider.of<InvitationsAndJoubJumsState>(context);
    final joubjums = invitationAndJoubJumState.joubJums;
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: joubjums.isEmpty ? Center(
              child: Text(
                'No new JoubJums',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ): ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              itemCount: joubjums.length,
              itemBuilder: (BuildContext context, int index) {
                return buildJoubJumCard(joubjums[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildJoubJumCard(Map<String, dynamic> joubjum) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => _onJoubJumTap(joubjum),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: boxColor,
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
                            'JoubJum with ${joubjum['creator']}',
                            style: const TextStyle(fontSize: 20, fontFamily: mainFont, color: textForeground),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0), // Space between title and details
                    Text(
                      'Date & Time: ${joubjum['date']}, ${joubjum['time']}\nLocation: ${joubjum['location']}',
                      style: const TextStyle(
                        color: appBarColor,
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

  Future<void> _onJoubJumTap(Map<String, dynamic> joubjum) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoubJumDetailsPage(joubjumDetails: joubjum),
      ),
    );
    if (result == 'delete') {
      setState(() {
        _onRejectPressed(joubjum);
      });
    }
  }

  void _onRejectPressed(Map<String, dynamic> joubjum) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cancel JoubJum from ${joubjum['creator']}'),
      ),
    );
    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false).deleteJoubJum(joubjum);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'JoubJums',
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