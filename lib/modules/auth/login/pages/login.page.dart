import 'package:driver/modules/auth/login/login.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../localization.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String message = "";

  updateMessage(String responseMessage) {
    debugPrint(responseMessage);
    message = responseMessage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
          builder: (context, model, child) => Scaffold(
                  body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/loginbg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/tedalal-logo.svg",
                                width: 160,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                Localization.of(context)?.tr('welcome') ?? "",
                                style: const TextStyle(
                                    fontSize: 30, fontFamily: "CairoBlack"),
                              ),
                              Text(
                                Localization.of(context)
                                        ?.tr('enter_your_phone_no') ??
                                    "",
                                style: const TextStyle(fontSize: 16),
                              ),
                              Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (v) {
                                      context.read<LoginProvider>().setPhone(v);
                                    },
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: Text(
                                Localization.of(context)?.tr(message) ?? "",
                                style: const TextStyle(color: Colors.red),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Submit(updateMessage: updateMessage)
                  ],
                ),
              ))),
    );
  }
}
