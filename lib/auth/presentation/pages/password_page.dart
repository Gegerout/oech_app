import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/otp_page.dart';
import 'package:oech_app/auth/presentation/pages/signin_page.dart';
import 'package:oech_app/auth/presentation/states/password_state.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttons.dart';
import '../states/signin_state.dart';
import '../widgets/text_field.dart';

class PasswordPage extends ConsumerWidget {
  PasswordPage({Key? key}) : super(key: key);

  final TextEditingController emailCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 110),
              Text(
                "Forgot Password",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: AppColors.textColor),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter your email address",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.grey2Color),
              ),
              const SizedBox(height: 48),
              Text(
                "Email Address",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.grey2Color),
              ),
              const SizedBox(height: 8),
              textField("***********@mail.com", (value) {
                ref.read(signinProvider.notifier).checkEmail(value);
              }, false, null, emailCont, TextInputType.emailAddress),
              const SizedBox(height: 64),
              SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: primaryButton("Send OTP", () {
                    if (!ref.watch(signinProvider).isEmail) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Wrong email"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"))
                                ],
                              ));
                    } else {
                      ref.read(passwordProvider.notifier).sendOtp(emailCont.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OtpPage(emailCont.text)));
                    }
                  }, FontWeight.w700, 16)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Remember password? Back to ",
                    style: TextStyle(fontSize: 14, color: AppColors.grey2Color),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  SizedBox(
                    width: 49,
                    height: 16,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SigninPage()));
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
