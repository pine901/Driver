import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/route.generator.dart';
import 'package:driver/secrets/secrets.dart';
import 'package:driver/theme/theme.colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, dynamic> _config;

  // ignore: constant_identifier_names
  const ENV_MODE = String.fromEnvironment('ENV_MODE', defaultValue: 'dev');
  // ignore: constant_identifier_names
  const EMU_MODE = String.fromEnvironment('EMU_MODE', defaultValue: 'on');

  _config = Config.firebaseEnviroments[ENV_MODE];

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: _config['apiKey'],
        appId: _config['appId'],
        messagingSenderId: _config['messagingSenderId'],
        projectId: _config['projectId']),
  );

  if (kDebugMode && EMU_MODE == 'on') {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost' ':8080',
        sslEnabled: false,
        persistenceEnabled: false);
  }

  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state!.setAndSaveLocale(locale);
  }

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Locale? _locale;

  void setAndSaveLocale(Locale locale) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('LANGUAGE_CODE', locale.languageCode);
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              theme: themeData,
              localizationsDelegates: const [
                Localization.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [Locale("ar", "SA"), Locale("en", "US")],
              localeResolutionCallback:
                  (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
                String? languageCode =
                    snapshot.data?.getString("LANGUAGE_CODE");
                if (languageCode == "en") {
                  return const Locale("en", "US");
                }
                if (languageCode == "ar") {
                  return const Locale("ar", "SA");
                }
                for (Locale locale in supportedLocales) {
                  if (locale.languageCode == deviceLocale!.languageCode &&
                      locale.countryCode == deviceLocale.countryCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: ThemeColors.primaryColor,
          );
        },
      ),
    );
  }
}
