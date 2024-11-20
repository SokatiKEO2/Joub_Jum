import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';

class CreateJoubJumPage extends StatefulWidget {
  final String location;
  final String placeId;

  const CreateJoubJumPage({
    super.key,
    required this.location,
    required this.placeId,
  });

  @override
  _CreateJoubJumPageState createState() => _CreateJoubJumPageState();
}

class _CreateJoubJumPageState extends State<CreateJoubJumPage> {
  late String location;
  late String placeId;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  late Map<String, dynamic> setUpJoubJum;

  //TODO Friend backends
  final List<Map<String, String>> _allFriends = [
    {"name": "Channa", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Sokly", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Rathana", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Makara", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Samnang", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Panha", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
    {"name": "Sokun", "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"},
  ];

  @override
  void initState() {
    super.initState();
    location = widget.location;
    placeId = widget.placeId;

    // Initialize the setUpJoubJum map here
    setUpJoubJum = {
      "user": "Kati",
      "date": "",
      "time": "",
      "location": location,
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": placeId,
      "invitees": <Map<String, String>>[], // Explicit type definition
    };
  }

  void _createJoubJum() {
    if (_formStateKey.currentState?.validate() == true) {
      _formStateKey.currentState?.save();

      // Ensure invitees are in the correct format
      setUpJoubJum['invitees'] = (setUpJoubJum['invitees'] as List<Map<String, String>>).map((invitee) {
        return {
          "name": invitee['name']!,
          "image": invitee['imagePath']!, // Ensure the key matches invitations
        };
      }).toList();

      // Create JoubJum
      Provider.of<InvitationsAndJoubJumsState>(context, listen: false).createJoubJum(setUpJoubJum);

      // Navigate back or show a success message
      Navigator.pop(context);
    }
  }


  void _addInvitee(Map<String, String> invitee) {
    setState(() {
      (setUpJoubJum['invitees'] as List<Map<String, String>>).add(invitee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1D5C9),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: const Color(0xFFC49551),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFE1D5C9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formStateKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Created by',
                                  ),
                                  initialValue: setUpJoubJum['user'],
                                  readOnly: true,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Location',
                                  ),
                                  initialValue: setUpJoubJum['location'],
                                  readOnly: true,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'DD/MM/YY',
                                    labelText: 'Date',
                                  ),
                                  validator: (value) => value == null || value.isEmpty
                                      ? 'Parameter Required'
                                      : null,
                                  onSaved: (value) => setUpJoubJum['date'] = value ?? '',
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: '9:00 AM',
                                    labelText: 'Time',
                                  ),
                                  validator: (value) => value == null || value.isEmpty
                                      ? 'Parameter Required'
                                      : null,
                                  onSaved: (value) => setUpJoubJum['time'] = value ?? '',
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Invitees:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "Raritas"
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        children: [
                                          ...(setUpJoubJum['invitees'] as List<Map<String, String>>)
                                              .map((invitee) =>
                                              _buildAvatarName(invitee['name']!, invitee['imagePath']!))
                                              .toList(),
                                          ElevatedButton(
                                            onPressed: () async {
                                              final selectedFriend = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => FriendSelectionPage(friends: _allFriends),
                                                ),
                                              );
                                              if (selectedFriend != null) {
                                                _addInvitee(selectedFriend);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              backgroundColor: const Color(0xFFC49551),
                                              minimumSize: const Size(30, 30),
                                            ),
                                            child: const Icon(Icons.add, size: 15, color: Colors.white,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createJoubJum,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                      ),
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'JoubJum Detail',
        style: TextStyle(fontSize: 25, fontFamily: "Raritas"),
      ),
      backgroundColor: const Color(0xFFC49551),
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildAvatarName(String name, String imagePath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 13.0,
          backgroundImage: NetworkImage(imagePath),
        ),
        const SizedBox(width: 5.0),
        Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ],
    );
  }
}

class FriendSelectionPage extends StatefulWidget {
  final List<Map<String, String>> friends;

  const FriendSelectionPage({super.key, required this.friends});

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
    _filteredFriends = widget.friends;
    _searchController.addListener(_updateSearchResults);
  }

  void _updateSearchResults() {
    setState(() {
      _filteredFriends = widget.friends
          .where((friend) => friend['name']!.toLowerCase().contains(_searchController.text.toLowerCase()))
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
                      _filteredFriends.remove(friend);
                      Navigator.pop(context, friend);
                    },
                  ),
                  onTap: () {
                    _filteredFriends.remove(friend);
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
