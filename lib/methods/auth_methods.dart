import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login(String username, String password) {
    return _auth.signInWithEmailAndPassword(
        email: username + '@cftusd.com', password: password);
  }

  Future<UserCredential> signup(String username, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: username + '@cftusd.com', password: password);
  }

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
