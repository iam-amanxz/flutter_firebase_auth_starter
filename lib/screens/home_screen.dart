import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton (
              child: const Text('Sign out'),
              onPressed: () {
                // final authProvider = Provider.of<AuthProvider>(context, listen: false);
                // authProvider.isLoggedIn = false;
              },
            ),
          ],
        )
      ),
    );
  }
}
