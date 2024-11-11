import 'package:flutter/material.dart';

import '../../consts.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  int _selectedIndex = 0;
  List<String> _friends = [
    "Kati", "Chamroeun", "Pich", "Kimhak", "Keameng", "Youhorng",
  ];
  List<String> _requests = [
    "Samnang", "Panha", "Sokun",
  ];

  // This method will be called when a bottom navigation item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _acceptRequest(String request) {
    setState(() {
      _friends.add(request);
      _requests.remove(request);
    });
  }

  void _rejectRequest(String request) {
    setState(() {
      _requests.remove(request);
    });
  }

  // Define the pages for the bottom navigation bar
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
      backgroundColor: Colors.white,
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

  Padding buildHeader(String header) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        header,
        style: const TextStyle(
          fontSize: 23, fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

// FriendListPage takes the dynamic friends list as a parameter
class FriendListPage extends StatelessWidget {
  final List<String> friends;

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

  Widget _buildFriendTile(String user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: buttonColor,
        ),
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(''), // Add the path to the image asset here
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 10.0),
            Text(
              user,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated RequestPage to StatefulWidget to allow for UI updates
class RequestPage extends StatefulWidget {
  final List<String> requests;
  final Function(String) accept;
  final Function(String) reject;

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

  Widget _buildRequestTile(String user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: buttonColor,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage(''), // Add the path to the image asset here
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  buildButtons(user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildButtons(String user) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              widget.accept(user);
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
              widget.reject(user);
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
