import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/auth/presentation/pages/new_pass_page.dart';
import 'package:pinput/pinput.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttons.dart';
import '../states/password_state.dart';

class OtpPage extends ConsumerWidget {
  OtpPage(this.email, {Key? key}) : super(key: key);

  final String email;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 110),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  "OTP Verification",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: AppColors.textColor),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  "Enter the 6 digit numbers sent to your email",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.grey2Color),
                ),
              ),
              const SizedBox(height: 70),
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(width: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Pinput(
                        length: 6,
                        controller: controller,
                        defaultPinTheme: PinTheme(
                            textStyle: const TextStyle(fontSize: 14),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.secondaryColor),
                            ),
                            margin: const EdgeInsets.only(right: 26.5)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "If you didn’t receive code,",
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
                          ref.read(passwordProvider.notifier).sendOtp(email);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          "Resend",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor),
                        )),
                  )
                ],
              ),
              const SizedBox(height: 84),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: primaryButton("Set New Password", () {
                      if (controller.text.length != 6) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Wrong code"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            ));
                      } else {
                        ref.read(passwordProvider.notifier).checkOtp(email, controller.text).then((value) {
                          if(value) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NewPassPage()));
                          }
                          else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Wrong code"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"))
                                  ],
                                ));
                          }
                        });
                      }
                    }, FontWeight.w700, 16)),
              ),
            ],
          ),
        ),
    );
  }
}
