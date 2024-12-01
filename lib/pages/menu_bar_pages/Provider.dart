import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvitationsAndJoubJumsState with ChangeNotifier {
  final List<Map<String, dynamic>> _invitations = [
    {
      "creator": "Panha",
      "user": "Kati",
      "date": "03/11/24",
      "time": "6:00 PM",
      "location": "Ambience Bar",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": "ChIJT17FJIlRCTERKJ2gjPwJf6A",
      "invitees": [
        {
          "name": "Kati",
          "image":
              "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        }
      ]
    },
  ];
  final List<Map<String, String>> _allFriends = [
    {
      "name": "Kati",
      "imagePath":
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'
    },
    {
      "name": "Chamroeun",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Pich",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Kimhak",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Keameng",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Youhorng",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
  ];

  final List<Map<String, String>> _notFriends = [
    {
      "name": "Channa",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Sokly",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Rathana",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Makara",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Samnang",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Panha",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
    {
      "name": "Sokun",
      "imagePath":
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
    },
  ];

  final List<Map<String, dynamic>> _joubJums = [];

  final List<Map<String, String>> _requests = [];

  List<Map<String, dynamic>> get invitations => _invitations;

  List<Map<String, dynamic>> get joubJums => _joubJums;

  List<Map<String, String>> get allFriends => _allFriends;

  List<Map<String, String>> get notFriends => _notFriends;

  List<Map<String, String>> get requests => _requests;

  void acceptInvitation(Map<String, dynamic> invitation) {
    _invitations.remove(invitation);

    Map<String, dynamic>? existingJoubJum;

    for (var joubJum in _joubJums) {
      if (joubJum['creator'] == invitation['creator']) {
        existingJoubJum = joubJum;
        break;
      }
    }

    if (existingJoubJum != null) {
      existingJoubJum['going'] ??= <Map<String, String>>[];
      existingJoubJum['going'].add({
        'name': invitation['user'].toString(),
        'image': invitation['imagePath'].toString(),
      });
    } else {
      final newJoubJum = {...invitation};
      newJoubJum['going'] = [
        {
          'name': invitation['creator'].toString(),
          'image': invitation['imagePath'].toString(),
        },
        {
          'name': invitation['user'].toString(),
          'image': invitation['imagePath'].toString(),
        }
      ];
      _joubJums.add(newJoubJum);
    }

    notifyListeners();
  }

  void rejectInvitation(Map<String, dynamic> invitation) {
    _invitations.remove(invitation);
    notifyListeners();
  }

  void createJoubJum(Map<String, dynamic> joubjum) {
    _joubJums.add(joubjum);
    _invitations.add(joubjum);
    notifyListeners();
  }

  void deleteJoubJum(Map<String, dynamic> joubjum) {
    _joubJums.remove(joubjum);
    notifyListeners();
  }

  void addMoreInvitees(
      Map<String, dynamic> joubjum, Map<String, String> invitee) {
    Map<String, dynamic>? specificJoubJum;

    for (var joubJum in _joubJums) {
      if (joubJum['creator'] == joubjum['creator']) {
        specificJoubJum = joubJum;
        break;
      }
    }
    if (specificJoubJum != null) {
      specificJoubJum['invitees'] ??= <Map<String, String>>[];
      specificJoubJum['invitees'].add({
        'name': invitee['name'].toString(),
        'image': invitee['imagePath'].toString(),
      });
    }

    notifyListeners();
  }

  void addFriend(Map<String, String> friend) {
    _allFriends.add(friend);
    notifyListeners();
  }

  void sendRequest(Map<String, String> friend) {
    _requests.add(friend);
    notifyListeners();
  }

  void rejectRequest(Map<String, String> request) {
    _requests.remove(request);
    notifyListeners();
  }

  void acceptRequest(Map<String, String> request) {
    _allFriends.add(request);
    _requests.remove(request);
    _notFriends.remove(request);
    notifyListeners();
  }

  void unFriend(Map<String, String> friend) {
    _allFriends.remove(friend);
    _notFriends.add(friend);
    notifyListeners();
  }
}

class UserDataProvider with ChangeNotifier {
  String _username = '';
  String _email = '';
  String _phonenum = '';

  String get username => _username;
  String get email => _email;
  String get phonenum => _phonenum;

  UserDataProvider() {
    // Fetch user data when the provider is created
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get the current user
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          _username = userData['username'];
          _email = userData['email'];
          _phonenum = userData['phonenum'];
          notifyListeners(); // Notify listeners to update UI
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
