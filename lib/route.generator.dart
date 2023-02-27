import 'package:flutter/material.dart';
import './pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {

////////////////////////////////////
////////////////////////////////////
////////////////////////////////////
      case '/':
        return MaterialPageRoute(builder: (_) => const SelectLanguage());

      // case '/auth-wrapper':
      //   return MaterialPageRoute(builder: (_) => const AuthWrapper());

      case '/login-page':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      // case '/delivery-location-page':
      //   return MaterialPageRoute(
      //       builder: (_) => const DeliveryLocationMapPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      // case '/store':
      //   return MaterialPageRoute(builder: (_) => const StorePage());

      // case '/confirm-order':
      //   return MaterialPageRoute(builder: (_) => const ConfirmOrderPage());

////////////////////////////////////
////////////////////////////////////
////////////////////////////////////
///////////// default
      default:
        return _errorRoute();
    }
  }

  // error route
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
