import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
//import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'map.dart';
import 'signin.dart';
import 'creategroup.dart';
import 'profile.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOC LOC',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const SignInForm(),
        '/home': (context) => const HomePage(),
        '/create-group': (context) => const CreateGroup(),
        '/profile': (context) => const Profile(),
        '/showmap': (context) => const ShowMap(),
      },
    );
  }
}
