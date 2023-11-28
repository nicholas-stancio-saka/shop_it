import 'package:firebase_auth/firebase_auth.dart';

class AppFirebaseAuth {
  final auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return auth.currentUser;
  }

  String? getCurrentUserId() {
    return getCurrentUser()?.uid;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> createAccount(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> loginWithEmail(String email, String password) async {
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetEmailPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    User? user = getCurrentUser();

    if (user == null) {
      throw Exception('No User Found');
    } else {
      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }

      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }
    }
  }
}

// TODO: Add Google Sign In