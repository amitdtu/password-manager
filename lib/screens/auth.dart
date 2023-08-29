import 'package:flutter/material.dart';
import 'package:password_manager/screens/signin.dart';
import 'package:password_manager/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  String? activeScreen;
  String masterPasswordHash = '';

  void showErrorMsg() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Something went wrong. Please reopen the app.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.redAccent,
    ));
  }

  Future<void> fetchMasterPassword() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? masterPassHash = prefs.getString('masterPassword') ?? "";

      print('master password hash $masterPassHash');

      setState(() {
        activeScreen = masterPassHash.isEmpty ? 'signup' : 'signin';
        masterPasswordHash = masterPassHash;
      });
    } catch (error) {
      showErrorMsg();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMasterPassword();
  }

  @override
  Widget build(context) {
    Widget screen = const Text('Loading...');

    if (activeScreen == 'signup') screen = const SignupScreen();
    if (activeScreen == 'signin') {
      screen = SigninScreen(masterPasswordHash);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Password Manager')),
      body: Center(child: screen),
    );
  }
}
