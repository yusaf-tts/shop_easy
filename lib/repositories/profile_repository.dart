import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> fetchUserDetails() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw Exception('User not authenticated');
      }
      final snapshot = await _userRef.child(currentUser.uid).get();
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      } else {
        throw Exception("User not found in database");
      }
    } catch (e) {
      throw Exception("Failed to fetch user details: $e");
    }
  }
}
