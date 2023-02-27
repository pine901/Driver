import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../theme/theme.colors.dart';
import '../notifications.controller.dart';
import 'widgets.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationModel>>(
      stream: NotificationController().getNotifications(),
      builder: (BuildContext context,
          AsyncSnapshot<List<NotificationModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ThemeColors.primaryColor)));
        }
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (!snapshot.hasData) {
          return const Center(child: Text("NO DATA"));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) => NotificationCard(
              notificationModel: snapshot.data![index],
            ),
          );
        }
      },
    );
  }
}
