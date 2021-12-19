import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/models/user.dart';
import 'package:flutter_firebase_test/providers/auth_provider.dart';
import 'package:flutter_firebase_test/screens/auth_screen.dart';
import 'package:flutter_firebase_test/screens/home_screen.dart';
import 'package:flutter_firebase_test/screens/login_screen.dart';
import 'package:flutter_firebase_test/screens/register_screen.dart';
import 'package:flutter_firebase_test/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ('/'),
        routes: {
          '/': (context)=> const AuthCheckPoint(),
          '/login': (context)=> const LoginScreen(),
          '/register': (context)=> const RegisterScreen(),
          '/home': (context)=> const HomeScreen(),
        }
      ),
    );
  }
}

class AuthCheckPoint extends StatelessWidget {
  const AuthCheckPoint({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
