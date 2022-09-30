import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      items: [
        DropdownMenuItem(
          value: 'logout',
          child: Row(
            children: const [
              Icon(Icons.exit_to_app),
              SizedBox(
                width: 8,
              ),
              Text('Logout'),
            ],
          ),
        )
      ],
      onChanged: (itemIdentifier) => {
        if (itemIdentifier == 'logout') {FirebaseAuth.instance.signOut()}
      },
    );
  }
}
