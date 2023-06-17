import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> getUserName() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return currentUser.displayName;
    }
    return null;
  }

  Future<bool> updateUserName(String name) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
