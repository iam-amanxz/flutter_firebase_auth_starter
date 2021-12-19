import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/models/user.dart';
import 'package:flutter_firebase_test/providers/auth_provider.dart';
import 'package:flutter_firebase_test/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Auth Screen'),
          ElevatedButton (
            child: const Text('Sign in with google'),
            onPressed: () async{
              // await _authService.signInWithGoogle();
              // final authProvider = Provider.of<AuthProvider>(context, listen: false);
              // authProvider.isLoggedIn = true;
            },
          ),],
        ),
      ),
    );
  }
}
