import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget with DiagnosticableTreeMixin{
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return true;
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: _isLoading ? const CircularProgressIndicator(): 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                    await authService.signInWithEmailAndPassword(email, password);
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
                child: const Text('Register'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
                }
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Continue With Google'),
                onPressed: () async {
                  try {
                    await authService.signInWithGoogle();
                    Navigator.of(context).pushReplacementNamed('/');
                  } catch (e) {
                    _setError(e.toString());
                  }
                }
              ),
              Text(_error ,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}