import 'package:flutter/material.dart';

class AddPasswordForm extends StatefulWidget {
  const AddPasswordForm({super.key});

  @override
  State<AddPasswordForm> createState() {
    return _AddPasswordForm();
  }
}

class _AddPasswordForm extends State<AddPasswordForm> {
  final formKey = GlobalKey<FormState>();

  String? enteredTitle;
  String? enteredAccount;
  String? enteredUsername;
  String? enteredPassword;
  String? enteredWebsite;

  void onSave() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      print(
          'enteredTitle $enteredTitle, enteredAccount $enteredAccount, enteredUsername $enteredUsername, enteredPassword $enteredPassword, enteredWebsite $enteredWebsite');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Password')),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  counter: Offstage(),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }

                  return null;
                },
                onSaved: (value) => enteredTitle = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Account'),
                  counter: Offstage(),
                ),
                maxLength: 50,
                onSaved: (value) => enteredAccount = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Username'),
                  counter: Offstage(),
                ),
                maxLength: 30,
                onSaved: (value) => enteredUsername = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Password'),
                  counter: Offstage(),
                ),
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }

                  return null;
                },
                onSaved: (value) => enteredPassword = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Website'),
                  counter: Offstage(),
                ),
                maxLength: 30,
                onSaved: (value) => enteredWebsite = value,
              ),
              ElevatedButton(onPressed: onSave, child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
