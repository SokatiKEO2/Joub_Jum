import 'package:flutter/material.dart';

class InvitationsAndJoubJumsState with ChangeNotifier {
  final List<Map<String, dynamic>> _invitations = [
    {
      "user": "Kati",
      "date": "03/11/24",
      "time": "6:00 PM",
      "location": "Ambience Bar",
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": "ChIJT17FJIlRCTERKJ2gjPwJf6A",
      "invitees": [
        {
          "name": "Kati",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        }
      ]
    },
    {
      "user": "Panha",
      "date": "04/11/24",
      "time": "8:00 PM",
      "location": "Hub",
      "imagePath": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "placeId": "ChIJ3VnQszZRCTER3Wc7W4e2DCw",
      "invitees": [
        {
          "name": "Pich",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        },
        {
          "name": "Panha",
          "image": "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _joubJums = [];

  List<Map<String, dynamic>> get invitations => _invitations;

  List<Map<String, dynamic>> get joubJums => _joubJums;

  void acceptInvitation(Map<String, dynamic> invitation) {
    _invitations.remove(invitation);
    _joubJums.add(invitation);
    notifyListeners();
  }

  void rejectInvitation(Map<String, dynamic> invitation) {
    _invitations.remove(invitation);
    notifyListeners();
  }

  void createJoubJum(Map<String, dynamic> joubjum){
    _joubJums.add(joubjum);
    notifyListeners();
  }

  void deleteJoubJum(Map<String, dynamic> joubjum){
    _joubJums.remove(joubjum);
    notifyListeners();
  }
}