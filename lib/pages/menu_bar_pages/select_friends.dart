import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';


class FriendSelectionPage extends StatefulWidget {

  final List<Map<String, String>> currentInvitees;

  const FriendSelectionPage({super.key, required this.currentInvitees});

  @override
  State<FriendSelectionPage> createState() => _FriendSelectionPageState();
}

class _FriendSelectionPageState extends State<FriendSelectionPage> {
  late TextEditingController _searchController;
  late List<Map<String, String>> _filteredFriends;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    final allFriends = Provider.of<InvitationsAndJoubJumsState>(context, listen: false).allFriends;
    final currentInvitees = widget.currentInvitees.map((invitee) => invitee['name']).toSet();

    _filteredFriends = allFriends
        .where((friend) => !currentInvitees.contains(friend['name']))
        .toList();

    _searchController.addListener(_updateSearchResults);
  }

  void _updateSearchResults() {
    final allFriends = Provider.of<InvitationsAndJoubJumsState>(context, listen: false).allFriends;
    final currentInvitees = widget.currentInvitees.map((invitee) => invitee['name']).toSet();

    setState(() {
      _filteredFriends = allFriends
          .where((friend) =>
      !currentInvitees.contains(friend['name']) &&
          friend['name']!.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Friends'),
        backgroundColor: const Color(0xFFC49551),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search friends...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredFriends.length,
              itemBuilder: (context, index) {
                final friend = _filteredFriends[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friend['imagePath']!),
                  ),
                  title: Text(friend['name']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pop(context, friend);
                    },
                  ),
                  onTap: () {
                    Navigator.pop(context, friend);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}