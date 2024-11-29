import 'package:flutter/material.dart';
import 'package:joub_jum/widgets/confirmation.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import 'Provider.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const FriendListPage(),
      const RequestPage(),
      const AddFriendPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: _buildAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded), label: 'Friends'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1_rounded), label: 'Requests'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_rounded), label: 'Add Friend'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Friends',
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

Padding buildHeader(String header) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      header,
      style: const TextStyle(
        fontSize: 25,
        fontFamily: mainFont,
      ),
    ),
  );
}

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  void unFriend(Map<String, String> friend) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unfriended ${friend['name']}'),
      ),
    );
    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
          .unFriend(friend);
    });
  }

  @override
  Widget build(BuildContext context) {
    final allFriendsState = Provider.of<InvitationsAndJoubJumsState>(context);
    final allFriends = allFriendsState.allFriends;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader('Friends List'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: allFriends.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildFriendTile(allFriends[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFriendTile(Map<String, String> friend) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: boxColor,
        ),
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  friend['imagePath']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                friend['name']!,
                style: const TextStyle(
                    color: textForeground, fontSize: 20, fontFamily: mainFont),
              ),
            ),
            _buildUnfriendButton(friend),
          ],
        ),
      ),
    );
  }

  Row _buildUnfriendButton(Map<String, String> friend) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: ElevatedButton(
            //TODO Confirmation
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Confirmation(
                        text: 'unfriend ${friend['name']}',
                        button: buildConfirmationButton(friend));
                  });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              backgroundColor: appBarColor,
            ),
            child: const Icon(
              Icons.person_remove_alt_1_rounded,
              color: boxColor,
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton buildConfirmationButton(Map<String, String> friend) {
    return ElevatedButton(
      onPressed: () {
        unFriend(friend);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2.0,
        backgroundColor: Colors.green,
      ),
      child: const Text(
        'Yes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

// Updated RequestPage to display requests' images and names
class RequestPage extends StatefulWidget {
  const RequestPage({
    super.key,
  });

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  void acceptRequest(Map<String, String> request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted request from ${request['name']}'),
      ),
    );
    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
          .acceptRequest(request);
    });
  }

  void rejectRequest(Map<String, String> request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rejected request from ${request['name']}'),
      ),
    );
    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
          .rejectRequest(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestState = Provider.of<InvitationsAndJoubJumsState>(context);
    final requests = requestState.requests;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader('Requests List'),
        Expanded(
          child: requests.isEmpty
              ? Center(
                  child: Text(
                    'No new requests',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: requests.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildRequestTile(requests[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildRequestTile(Map<String, String> request) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: boxColor,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  request['imagePath']!,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    request['name']!,
                    style: const TextStyle(
                        color: textForeground,
                        fontSize: 23,
                        fontFamily: mainFont),
                  ),
                  const SizedBox(height: 8.0),
                  buildButtons(request),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildButtons(Map<String, String> request) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              acceptRequest(request);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2.0,
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Accept',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              rejectRequest(request);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2.0,
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Reject',
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
}

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({
    super.key,
  });

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  late final TextEditingController _searchController;
  List<Map<String, String>> _searchResults = [];
  bool _isTyping = false; // Indicates if the user is typing in the search bar.

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_updateSearchResults);
  }

  void _updateSearchResults() {
    setState(() {
      _isTyping = _searchController.text.isNotEmpty;
      if (_isTyping) {
        _searchResults =
            Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
                .notFriends
                .where((friend) => friend['name']!
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
                .toList();
      } else {
        _searchResults = [];
      }
    });
  }

  void _onSendRequest(Map<String, String> friend) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request sent to ${friend['name']}')),
    );

    setState(() {
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
          .sendRequest(friend);
      _searchController.clear(); // Clear the search bar
    });
  }

  bool _isRequestSent(String name) {
    return Provider.of<InvitationsAndJoubJumsState>(context, listen: false)
        .requests
        .any((request) => request['name'] == name);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search friends...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              prefixIcon: const Icon(Icons.search),
            ),
            onTap: () {
              setState(() {
                _isTyping = false; // Do not show results until typing starts
              });
            },
          ),
        ),
        Expanded(
          child: !_isTyping
              ? Center(
                  child: Text(
                    'Start typing to search friends',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : _searchResults.isEmpty
                  ? Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final friend = _searchResults[index];
                        final isRequestSent = _isRequestSent(friend['name']!);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(friend['imagePath']!),
                          ),
                          title: Text(friend['name']!),
                          trailing: isRequestSent
                              ? ElevatedButton(
                                  onPressed: null, // Disable the button
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade400,
                                  ),
                                  child: const Text('Request Sent'),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: appBarColor,
                                    foregroundColor: bodyColor,
                                  ),
                                  onPressed: () => _onSendRequest(friend),
                                  child: const Text('Send Request'),
                                ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
