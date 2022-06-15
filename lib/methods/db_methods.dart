import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> allCoins() {
    return _db.collection('coins').snapshots();
  }

  Stream<DocumentSnapshot> getUserData(String uid) {
    return _db.doc('users/$uid').snapshots();
  }

  Future addUser(String uid, String name, String email, String password) {
    return _db.doc('users/$uid').set({
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': DateTime.now().microsecondsSinceEpoch,
      'amount': 0,
    });
  }
}
