import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'home.dart';
import 'map.dart';
import 'signin.dart';
import 'creategroup.dart';
import 'profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/showmap': (context) => MapScreen(groupId: 0),
      },
    );
  }
}
