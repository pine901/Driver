import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _canSubmit = false;
  bool get canSubmit => _canSubmit;
  setCanSubmit(String phone) {
    if (phone.length == 10) {
      _canSubmit = true;
      notifyListeners();
    }
    if (phone.length < 10) {
      _canSubmit = false;
      notifyListeners();
    }
  }

  String _phone = "";
  String get phone => _phone;
  setPhone(String phone) {
    _phone = phone;
    setCanSubmit(phone);
  }
}
