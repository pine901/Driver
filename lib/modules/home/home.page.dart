import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../pages.dart';
import 'widgets/home.bottom.navigation.bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseMessaging messaging;

  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
    const OrdersPage(),
    const NotificationsPage(),
    const OrdersHistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    // messaging.requestPermission();
    messaging.getToken().then((value) {
      debugPrint(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          );
        },
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTap: _onItemTapped,
      ),
    );
  }
}
