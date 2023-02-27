import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../auth/auth.wrapper.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          String? languageCode = snapshot.data?.getString("LANGUAGE_CODE");
          if (languageCode == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        MyApp.setLocale(context, const Locale('ar', 'SA'));
                        Phoenix.rebirth(context);
                      },
                      child: const Text("عربي")),
                  TextButton(
                      onPressed: () {
                        MyApp.setLocale(context, const Locale('en', 'US'));
                        Phoenix.rebirth(context);
                      },
                      child: const Text("English"))
                ],
              ),
            );
          }
          return const AuthWrapper();
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
