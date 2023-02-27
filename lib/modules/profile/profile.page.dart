import 'package:flutter/material.dart';

import '../../services/auth.service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () async {
                await AuthService().sigout();
                Navigator.pushReplacementNamed(context, '/login-page');
              },
              child: const Text("Signout"))),
    );
  }
}
