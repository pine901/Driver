import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:dio/dio.dart';

import '../../../../services/auth.service.dart';
import '../widgets/otp.input.dart';

class VerifyCodePage extends StatefulWidget {
  final String phone;
  final bool wait;
  const VerifyCodePage({Key? key, required this.phone, required this.wait})
      : super(key: key);

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  String wrongCodeMessage = "";
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    if (widget.wait) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 600), () {
          _showToast();
        });
      });
    }
  }

  _showToast() {
    Widget toast = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.warning_amber_outlined,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Flexible(
            child: Text(
              'تم إرسال الرقم السري المؤقت لك مسبقاً. \n يرجى اعادة المحاولة بعد 120 ثانية لإنشاء رقم سري جديد.',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  updateWrongCodeMessage(String message) {
    wrongCodeMessage = message;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: const Text(
            "تسجيل الدخول",
            style: TextStyle(fontSize: 16, color: Colors.black),
          )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "أدخل الرمز المكون من 4 أرقام",
                    style: TextStyle(fontSize: 18, fontFamily: "CairoBold"),
                  ),
                  Text("المرسل للرقم ${widget.phone}"),
                  OTPInpunt(
                      phone: widget.phone,
                      updateWrongCodeMessage: updateWrongCodeMessage),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        wrongCodeMessage,
                        style: const TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ),
            SafeArea(
                top: false,
                child: TextButton(
                  child: const Text(
                    "إعادة إرسال الرمز",
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: () async {
                    try {
                      context.loaderOverlay.show();
                      Response response =
                          await AuthService().createCode(widget.phone);
                      context.loaderOverlay.hide();
                      if (response.data['wait']) {
                        _showToast();
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
