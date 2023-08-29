import 'package:flutter/material.dart';
import 'package:password_manager/screens/home.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreen();
  }
}

class _SignupScreen extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final _masterPasswordController = TextEditingController();

  var enteredConfirmMasterPassword = '';
  var enteredMasterPassword = '';

  @override
  void dispose() {
    _masterPasswordController.dispose();
    super.dispose();
  }

  void showSuccessMsg() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Password Saved'),
      duration: Duration(seconds: 3),
    ));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> onSave() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final hashedPassword = createHash(enteredMasterPassword);

        await prefs.setString('masterPassword', hashedPassword);
        showSuccessMsg();
      } catch (error) {
        // print(error);
      }
    }
  }

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 20),
      child: Column(children: [
        const Text(
          'Welcome to the password manager app. Please set master password and make sure you don\'t forget it. Otherwise your all data will be lost.',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _masterPasswordController,
                obscureText: true,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Master Password'),
                  counter: Offstage(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  } else if (value.trim().length <= 3) {
                    return 'Master password must be at least 4 characters';
                  }

                  return null;
                },
                onSaved: (value) {
                  enteredMasterPassword = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                maxLength: 50,
                decoration: const InputDecoration(
                  counter: Offstage(),
                  label: Text('Confirm Master Password'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  } else if (_masterPasswordController.text != value) {
                    return 'Passwords are not same';
                  }

                  return null;
                },
                onSaved: (value) {
                  enteredConfirmMasterPassword = value!;
                },
              ),
              ElevatedButton(onPressed: onSave, child: const Text('Save'))
            ],
          ),
        )
      ]),
    );
  }
}
