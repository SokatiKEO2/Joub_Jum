import 'package:flutter/material.dart';
import 'package:joub_jum/widgets/confirmation.dart';

import '../../consts.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _friends = [
    {"name": "Kati", "imagePath": 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'},
    {"name": "Chamroeun", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Pich", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Kimhak", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Keameng", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Youhorng", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
  ];
  final List<Map<String, String>> _requests = [];

  final List<Map<String, String>> _allFriends = [
    {"name": "Channa", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Sokly", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Rathana", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Makara", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Samnang", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Panha", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Sokun", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _sendRequest(Map<String, String> friend) {
    setState(() {
      _requests.add(friend);
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FriendListPage(friends: _friends, unFriend: _unFriend),
      RequestPage(requests: _requests, accept: _acceptRequest, reject: _rejectRequest),
      AddFriendPage(
        allFriends: _allFriends,
        requests: _requests,
        onSendRequest: _sendRequest,
      ),
    ];
  }

  void _acceptRequest(Map<String, String> request) {
    setState(() {
      _friends.add(request);
      _requests.remove(request);

      // Remove from _allFriends if present
      _allFriends.removeWhere((friend) => friend['name'] == request['name']);
    });

  }

  void _rejectRequest(Map<String, String> request) {
    setState(() {
      _requests.remove(request);
    });
  }

  void _unFriend(Map<String, String> request) {
    setState(() {
      _friends.remove(request);
      _allFriends.add(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: _buildAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_1_rounded), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.person_search_rounded), label: 'Add Friend'),
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
        fontSize: 25, fontFamily: mainFont,
      ),
    ),
  );
}

class FriendListPage extends StatefulWidget {
  final List<Map<String, String>> friends;
  final Function(Map<String, String>) unFriend;

  const FriendListPage({super.key, required this.friends, required this.unFriend});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader('Friends List'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: widget.friends.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildFriendTile(widget.friends[index]);
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
                  color: textForeground,
                  fontSize: 20,
                  fontFamily: mainFont
                ),
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
                    return Confirmation(text: 'unfriend ${friend['user']}', function: widget.unFriend(friend));
                  });
              setState(() {});
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
}

// Updated RequestPage to display requests' images and names
class RequestPage extends StatefulWidget {
  final List<Map<String, String>> requests;
  final Function(Map<String, String>) accept;
  final Function(Map<String, String>) reject;

  const RequestPage({super.key, required this.requests, required this.accept, required this.reject});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader('Requests List'),
        Expanded(
          child: widget.requests.isEmpty ? Center(
            child: Text(
              'No new requests',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),
          ) : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: widget.requests.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildRequestTile(widget.requests[index]);
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
                        fontFamily: mainFont
                    ),
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
              widget.accept(request);
              setState(() {}); // Refresh the UI after accepting
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
              widget.reject(request);
              setState(() {}); // Refresh the UI after rejecting
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
  final List<Map<String, String>> allFriends;
  final List<Map<String, String>> requests;
  final Function(Map<String, String>) onSendRequest;

  const AddFriendPage({
    super.key,
    required this.allFriends,
    required this.requests,
    required this.onSendRequest,
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
        _searchResults = widget.allFriends
            .where((friend) => friend['name']!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
      } else {
        _searchResults = [];
      }
    });
  }

  bool _isRequestSent(String name) {
    return widget.requests.any((request) => request['name'] == name);
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
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0)
              ),
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
          child: !_isTyping ? Center(
            child: Text(
              'Start typing to search friends',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ) : _searchResults.isEmpty ? Center(
            child: Text(
              'No results found',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ) : ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final friend = _searchResults[index];
              final isRequestSent = _isRequestSent(friend['name']!);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(friend['imagePath']!),
                ),
                title: Text(friend['name']!),
                trailing: isRequestSent ? ElevatedButton(
                  onPressed: null, // Disable the button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                  ),
                  child: const Text('Request Sent'),

                ) : ElevatedButton(
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

  void _onSendRequest(Map<String, String> friend) {
    widget.onSendRequest(friend);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request sent to ${friend['name']}')),
    );

    setState(() {
      _searchController.clear(); // Clear the search bar
    });
  }
}