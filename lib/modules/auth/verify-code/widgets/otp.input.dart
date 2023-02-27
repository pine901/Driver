import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../services/services.dart';

class OTPInpunt extends StatelessWidget {
  final String phone;
  final Function updateWrongCodeMessage;
  const OTPInpunt(
      {Key? key, required this.phone, required this.updateWrongCodeMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OTPTextField(
        length: 4,
        width: MediaQuery.of(context).size.width,
        fieldWidth: 60,
        style: const TextStyle(fontSize: 17),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onCompleted: (pin) async {
          try {
            updateWrongCodeMessage("");
            context.loaderOverlay.show();
            Response response = await AuthService().verifyCode(phone, pin);
            context.loaderOverlay.hide();
            if (response.data['success']) {
              await FirebaseAuth.instance
                  .signInWithCustomToken(response.data['customToken']);
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (response.data['success'] == false) {
              updateWrongCodeMessage("الرقم السري المدخل غير صحيح");
            }
          } catch (e) {
            context.loaderOverlay.hide();
            debugPrint(e.toString());
          }
        },
      ),
    );
  }
}
