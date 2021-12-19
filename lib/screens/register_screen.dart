import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _error = '';
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _setError(String error) {
    setState(() {
      _error = error;
    });
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  bool _validateForm(String email, String password) {
    if(email.isEmpty){
      _setError('Email is required');
      return false;
    }
    if(password.isEmpty){
      _setError('Password is required');
      return false;
    }
    if(password.isNotEmpty && password.length < 6){
      _setError('Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

  final authService = Provider.of<AuthService>(context);

  return Scaffold(
    appBar: AppBar(
      title: const Text('Register'),
    ),
    body: Center(
      child: _isLoading ? const CircularProgressIndicator():
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () async {
                _setLoading(true);

                setState(() {
                  _error = '';
                });

                String email = emailController.text.trim();
                String password = passwordController.text;

                bool isFormValid =  _validateForm(email, password);

                if(!isFormValid){
                  _setLoading(false);
                  return;
                }

                try {
                  await authService.registerWithEmailAndPassword(email, password);
                  Navigator.of(context).pushReplacementNamed('/'); 
                } catch (e) {
                  _setError(e.toString());
                } finally{
                  _setLoading(false);
                }             
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            ),
            const SizedBox(height: 16),
            Text(
              _error,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    ),
    );
  }
}