import 'package:attendanceapp1/homescreen.dart';
import 'package:attendanceapp1/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(
           seedColor: const Color(0xFF007BFE),  // Replace with your desired primary color
           brightness: Brightness.light,  // Adjust for light or dark theme
         ),
      ),
      home: const KeyboardVisibilityProvider(
        child: AuthCheck(),
        ),
      );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    _getCurrentUse();
  }

  void _getCurrentUser() {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if(sharedPreferences.getString('employeeId') != null) {
        setState(() {
          userAvailable = true;
        });
      }
    } catch(e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? HomeScreen() : const LoginScreen();
  }
}