import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_attendence_app/constants/network_objects.dart';
import 'package:online_attendence_app/firebase_options.dart';
import 'package:online_attendence_app/screens/login_screen.dart';
import 'package:online_attendence_app/screens/nav_bar_controller_screen.dart';

void main() async {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (firebaseAuth.currentUser == null)
          ? LoginScreen()
          : NavBarControllerScreen(),
    );
  }
}
