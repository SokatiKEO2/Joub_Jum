import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> fetchUserData() async {
  User? user = FirebaseAuth.instance.currentUser; // Get the current user
  if (user != null) {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (doc.exists) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      //Use userData['username'],  userData['phonenum']
      return userData;
    }
  }
  return null;
}
