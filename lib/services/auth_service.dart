import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_firebase_test/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  User? _userFromFirebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      displayName: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  Stream<User?>? get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async{

    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(credential.user); 
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async{
    
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(credential.user); 
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async{
    return await _auth.signOut();
  }
}
