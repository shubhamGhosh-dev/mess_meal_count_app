import 'package:flutter/material.dart';
import 'package:meal_count/manage_members.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Ritwika Mess'),
          ),
          ListTile(
            tileColor: const Color.fromARGB(255, 129, 199, 132),
            leading: const Icon(
              Icons.person_4,
              color: Colors.white,
            ),
            title: const Text(
              'Manage Mess Members',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ManageMembers(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
