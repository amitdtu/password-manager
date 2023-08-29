import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.asset(
                    'assets/logo.webp',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'My Passwords',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          ListTile(
            horizontalTitleGap: 10,
            leading: const Icon(
              Icons.settings,
              size: 32,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
