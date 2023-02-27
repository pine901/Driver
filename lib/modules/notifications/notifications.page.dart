import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("التنبيهات"), automaticallyImplyLeading: false),
      body: const NotificationsList(),
    );
  }
}
