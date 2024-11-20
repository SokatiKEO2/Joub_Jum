import 'package:flutter/material.dart';

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
  final List<Map<String, String>> _requests = [
    {"name": "Samnang", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Panha", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Sokun", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _acceptRequest(Map<String, String> request) {
    setState(() {
      _friends.add(request);
      _requests.remove(request);
    });
  }

  void _rejectRequest(Map<String, String> request) {
    setState(() {
      _requests.remove(request);
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FriendListPage(friends: _friends),
      RequestPage(requests: _requests, accept: _acceptRequest, reject: _rejectRequest),
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
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_1_rounded), label: 'Requests'),
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
        style: TextStyle(fontSize: 25, fontFamily: 'Raritas')
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
        fontSize: 25, fontFamily: 'Raritas'
      ),
    ),
  );
}

// FriendListPage with updated structure to display friends' images and names
class FriendListPage extends StatelessWidget {
  final List<Map<String, String>> friends;

  const FriendListPage({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader('Friends List'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: friends.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildFriendTile(friends[index]);
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
            Text(
              friend['name']!,style: TextStyle(fontSize: 20, fontFamily: 'Raritas', color: bodyColor),
            ),
          ],
        ),
      ),
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
                    style: TextStyle(fontSize: 20, fontFamily: 'Raritas', color: bodyColor),
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
