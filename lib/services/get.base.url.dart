import 'package:flutter/foundation.dart';
import 'dart:io';
import '../secrets/secrets.dart';

String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';

String getBaseApiUrl() {
  // ignore: constant_identifier_names
  const API_MODE = String.fromEnvironment('API_MODE', defaultValue: 'local');
  // ignore: constant_identifier_names
  const ENV_MODE = String.fromEnvironment('ENV_MODE', defaultValue: 'dev');

  String _envApiUrl = Config.baseApiUrl[API_MODE][ENV_MODE];

  if (kDebugMode && API_MODE == 'local') {
    String _platFormHost =
        Platform.isIOS ? 'http://$host:5001/' : 'http://$host:5001/';
    return "$_platFormHost$_envApiUrl";
  }

  return _envApiUrl;
}
