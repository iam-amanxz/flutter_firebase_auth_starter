import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_firebase_test/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn() as GoogleSignInAccount;
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final auth.UserCredential authResult = await _auth.signInWithCredential(credential);
      final auth.User user = authResult.user as auth.User;
      return _userFromFirebaseUser(user);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async{
    return await _auth.signOut();
  }
}
