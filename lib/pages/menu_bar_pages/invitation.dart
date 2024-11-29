import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/menu_bar_pages/invitation_details.dart';
import 'package:joub_jum/pages/menu_bar_pages/Provider.dart';
import 'package:provider/provider.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {

  @override
  Widget build(BuildContext context) {
    final invitationAndJoubJumState = Provider.of<InvitationsAndJoubJumsState>(context);
    final invitations = invitationAndJoubJumState.invitations;
    return Scaffold(
        backgroundColor: bodyColor,
        appBar: _buildAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: invitations.isEmpty ? Center(
                child: Text(
                'No new invitations',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
              ): ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                itemCount: invitations.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildInvitations(invitations[index]);
                },
              ),
            ),
          ],
        )
    );
  }

  Widget buildInvitations(Map<String, dynamic> invitation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => _onInvitationTap(invitation),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: boxColor,
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(
                    invitation['imagePath']!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  '${invitation['creator']} sent an invite',
                  style: TextStyle(fontSize: 20, fontFamily: mainFont, color: textForeground),
                ),
              ),
              buildButtons(invitation),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onInvitationTap(Map<String, dynamic> invitation) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvitationDetailsPage(invitationDetails: invitation),
      ),
    );
    if (result == 'accept') {
      setState(() {
        _onAcceptPressed(invitation);
      });
    }
    else if (result == 'reject'){
      setState(() {
        _onRejectPressed(invitation);
      });
    }
  }

  Row buildButtons(Map<String, dynamic> invitation) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: ElevatedButton(
            onPressed: () => _onRejectPressed(invitation),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'X',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 35,
          height: 35,
          child: ElevatedButton(
            onPressed: () => _onAcceptPressed(invitation),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: Colors.green,
            ),
            child: const Text(
              '✓',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onRejectPressed(Map<String, dynamic> invitation) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reject invite from ${invitation['creator']}'),
      ),
    );
    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false).rejectInvitation(invitation);
    });
  }

  void _onAcceptPressed(Map<String, dynamic> invitation) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accept invite from ${invitation['creator']}'),
      ),
    );
    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false).acceptInvitation(invitation);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Invitations',
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
