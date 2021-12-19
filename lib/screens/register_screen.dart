import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              child: const Text('Register'),
              onPressed: () async {
                // ignore: todo
                // TODO: implement validations
                await authService.registerWithEmailAndPassword(emailController.text, passwordController.text);
                // Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login');
              }
            ),
          ],
        ),
      ),
      
    );
  }
}