import 'package:flutter/material.dart';

Drawer homeDrawer(context) {
  return Drawer(
    child: Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            drawerHeader(context),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        drawerItem(
                            context, 'assets/drawer/user.png', 'personal_data',
                            () {
                          Navigator.of(context).pushNamed('/personal-data');
                        }),
                        drawerItem(
                            context, 'assets/drawer/bills.png', 'invoices', () {
                          Navigator.of(context).pushNamed('/invoices');
                        }),
                        drawerItem(
                            context, 'assets/drawer/support.png', 'support',
                            () {
                          Navigator.of(context).pushNamed('/support');
                        }),
                        drawerItem(
                            context, 'assets/drawer/settings.png', 'settings',
                            () {
                          Navigator.of(context).pushNamed('/change-language');
                        }),
                      ],
                    ),
                  ),
                  // SafeArea(
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 24),
                  //     child: drawerItem(
                  //         context, 'assets/drawer/signout.png', 'sign_out',
                  //         () async {
                  //       try {
                  //         await FirebaseAuth.instance.signOut();
                  //         Navigator.pushAndRemoveUntil(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (BuildContext context) =>
                  //                   AuthWrapper()),
                  //           ModalRoute.withName('/'),
                  //         );
                  //       } catch (e) {
                  //         print(e);
                  //       }
                  //     }),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// drawer header
Widget drawerHeader(context) {
  return SizedBox(
    height: 140.0,
    child: DrawerHeader(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.all(40),
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Image.asset(
            'assets/logo.png',
            color: Colors.white,
          ),
        )),
  );
}

// drawer item
Widget drawerItem(context, String iconPath, String key, Function function) {
  return InkWell(
    child: Row(
      children: <Widget>[
        Image.asset(
          iconPath,
          width: 20,
          color: Colors.black38,
        ),
        const SizedBox(
          width: 20,
        ),
        // Text(
        //   getTranslated(context, key),
        //   style: TextStyle(fontSize: 14),
        // ),
        const SizedBox(
          height: 60,
        )
      ],
    ),
    // onTap: function,
  );
}
