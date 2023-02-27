import 'package:flutter/material.dart';

import '../../../models/models.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({Key? key, required this.notificationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.network(notificationModel.iconUrl),
              title: Text(notificationModel.title),
              subtitle: Text(notificationModel.subtitle),
            ),
          ],
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ProposalPage(
          //         proposalNotificationData: notificationModel.data),
          //   ),
          // );
        },
      ),
    );
  }
}
