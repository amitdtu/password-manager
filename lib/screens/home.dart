import 'package:flutter/material.dart';
import 'package:password_manager/screens/add_password_form.dart';
import 'package:password_manager/screens/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onPressPlusBtn(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const AddPasswordForm(),
      ),
    );
    // showModalBottomSheet(
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (ctx) => const AddPasswordForm(),
    // );
  }

  @override
  Widget build(context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('My Password Manager')),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  onPressed: () => onPressPlusBtn(context),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
