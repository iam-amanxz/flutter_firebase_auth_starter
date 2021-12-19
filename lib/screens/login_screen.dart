import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                // ignore: todo
                // TODO: implement validations
                await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                print('Register Clicked');
                Navigator.popAndPushNamed(context, '/register');
              }
            ),
          ],
        ),
      ),
      
    );
  }
}