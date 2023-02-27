import 'package:dio/dio.dart';
import 'package:driver/modules/auth/login/login.provider.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../../../localization.dart';
import '../../../../services/auth.service.dart';
import '../../../../theme/theme.colors.dart';
import '../../verify-code/pages/verify.code.page.dart';

class Submit extends StatefulWidget {
  final Function updateMessage;
  const Submit({Key? key, required this.updateMessage}) : super(key: key);

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: context.watch<LoginProvider>().canSubmit
            ? ThemeColors.primaryColor
            : Colors.black54,
        child: SafeArea(
            top: false,
            child: TextButton(
                onPressed: () async {
                  if (context.read<LoginProvider>().canSubmit) {
                    String phone = context.read<LoginProvider>().phone;
                    try {
                      context.loaderOverlay.show();
                      Response response = await AuthService()
                          .createCode(context.read<LoginProvider>().phone);
                      context.loaderOverlay.hide();
                      // debugPrint(response.data['driver'].toString());
                      widget.updateMessage(response.data['message']);
                      if (response.data['driver'] &&
                          response.data['account'] &&
                          response.data['profile']) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodePage(
                                    phone: phone,
                                    wait: response.data['wait'],
                                  )),
                        );
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                },
                child: Text(
                  Localization.of(context)?.tr('next') ?? "",
                  style: const TextStyle(color: Colors.white),
                ))));
  }
}
