import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_firebase_test/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    // Todo: implement validations
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return _userFromFirebaseUser(credential.user); 
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async{
    // Todo: implement validations
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    return _userFromFirebaseUser(credential.user); 
  }

  Future<void> signOut() async{
    return await _auth.signOut();
  }
}
